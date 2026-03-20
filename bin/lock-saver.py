#!/home/mihailo/bin/.lock-venv/bin/python
"""Native OpenGL saver — renders Lenia directly into $XSCREENSAVER_WINDOW."""
import os, sys, time, math, random, signal
import ctypes
from ctypes import c_int, c_uint, c_long, c_ulong, c_char_p, c_void_p, c_float, byref, POINTER, Structure

# ── Load libraries ──
X11 = ctypes.cdll.LoadLibrary("libX11.so.6")
GL  = ctypes.cdll.LoadLibrary("libGL.so.1")

# ── X11 types and structs ──
Display_p = c_void_p
Window    = c_ulong
XID       = c_ulong
Colormap  = c_ulong
Bool      = c_int

class XWindowAttributes(Structure):
    _fields_ = [
        ("x", c_int), ("y", c_int),
        ("width", c_int), ("height", c_int),
        ("border_width", c_int), ("depth", c_int),
        ("visual", c_void_p), ("root", Window),
        ("c_class", c_int), ("bit_gravity", c_int),
        ("win_gravity", c_int), ("backing_store", c_int),
        ("backing_planes", c_ulong), ("backing_pixel", c_ulong),
        ("save_under", Bool), ("colormap", Colormap),
        ("map_installed", Bool), ("map_state", c_int),
        ("all_event_masks", c_long), ("your_event_mask", c_long),
        ("do_not_propagate_mask", c_long),
        ("override_redirect", Bool), ("screen", c_void_p),
    ]

# ── GLX constants ──
GLX_RGBA         = 4
GLX_DEPTH_SIZE   = 12
GLX_DOUBLEBUFFER = 5
GLX_RED_SIZE     = 8
GLX_GREEN_SIZE   = 9
GLX_BLUE_SIZE    = 10
GLX_NONE         = 0

# ── GLX function prototypes ──
GL.glXChooseVisual.restype = c_void_p
GL.glXChooseVisual.argtypes = [Display_p, c_int, POINTER(c_int)]
GL.glXCreateContext.restype = c_void_p
GL.glXCreateContext.argtypes = [Display_p, c_void_p, c_void_p, Bool]
GL.glXMakeCurrent.restype = Bool
GL.glXMakeCurrent.argtypes = [Display_p, Window, c_void_p]
GL.glXSwapBuffers.argtypes = [Display_p, Window]

# ── X11 function prototypes ──
X11.XOpenDisplay.restype = Display_p
X11.XOpenDisplay.argtypes = [c_char_p]
X11.XGetWindowAttributes.argtypes = [Display_p, Window, POINTER(XWindowAttributes)]
X11.XDefaultScreen.restype = c_int
X11.XDefaultScreen.argtypes = [Display_p]
X11.XFlush.argtypes = [Display_p]
X11.XPending.restype = c_int
X11.XPending.argtypes = [Display_p]

# ── Get XSCREENSAVER_WINDOW ──
xid_str = os.environ.get("XSCREENSAVER_WINDOW", "0")
xid = int(xid_str, 0) if xid_str.startswith("0x") else int(xid_str)
if xid == 0:
    print("No XSCREENSAVER_WINDOW set", file=sys.stderr)
    sys.exit(1)

# ── Open display, get window size ──
dpy = X11.XOpenDisplay(None)
if not dpy:
    print("Cannot open X display", file=sys.stderr)
    sys.exit(1)

attrs = XWindowAttributes()
X11.XGetWindowAttributes(dpy, xid, byref(attrs))
W, H = attrs.width, attrs.height
print(f"lock-saver: rendering into {hex(xid)} {W}x{H}", file=sys.stderr)

# ── Create GLX context on the existing window ──
screen = X11.XDefaultScreen(dpy)
attribs = (c_int * 13)(
    GLX_RGBA, GLX_DOUBLEBUFFER,
    GLX_RED_SIZE, 8, GLX_GREEN_SIZE, 8, GLX_BLUE_SIZE, 8,
    GLX_DEPTH_SIZE, 0, GLX_NONE
)
vi = GL.glXChooseVisual(dpy, screen, attribs)
if not vi:
    print("No suitable GLX visual", file=sys.stderr)
    sys.exit(1)

ctx = GL.glXCreateContext(dpy, vi, None, True)
if not ctx:
    print("Cannot create GLX context", file=sys.stderr)
    sys.exit(1)

GL.glXMakeCurrent(dpy, xid, ctx)

# ── Now import OpenGL (context must exist first) ──
from OpenGL.GL import *

# ── Parameters (matching lockscreen.html) ──
CELL_SIZE = 4
GRID_W = W // CELL_SIZE
GRID_H = H // CELL_SIZE
SIM_STEPS = 2
TEMPORAL_BLEND = 0.0
COLOR_CUR = (0x60/255, 0x40/255, 0xa8/255)
COLOR_OCC = (0xc8/255, 0xa8/255, 0xf0/255)

# ── Shader helpers ──
def compile_shader(src, stype):
    s = glCreateShader(stype)
    glShaderSource(s, src)
    glCompileShader(s)
    if not glGetShaderiv(s, GL_COMPILE_STATUS):
        raise RuntimeError(glGetShaderInfoLog(s).decode())
    return s

def create_program(vs_src, fs_src):
    p = glCreateProgram()
    glAttachShader(p, compile_shader(vs_src, GL_VERTEX_SHADER))
    glAttachShader(p, compile_shader(fs_src, GL_FRAGMENT_SHADER))
    glLinkProgram(p)
    if not glGetProgramiv(p, GL_LINK_STATUS):
        raise RuntimeError(glGetProgramInfoLog(p).decode())
    return p

# ── Shaders (desktop GLSL — drop WebGL precision qualifiers) ──
VERT = """
#version 120
attribute vec2 a_pos;
void main() { gl_Position = vec4(a_pos, 0.0, 1.0); }
"""

SIM = """
#version 120
uniform sampler2D u_state;
uniform sampler2D u_kernel;
uniform float u_gridWidth;
uniform float u_gridHeight;
uniform vec3 u_mouse;
uniform float u_time;
uniform float u_kernelNorm;

const float R = 15.0;
const float DT = 0.05;
const float KERNEL_SIZE = 31.0;
const float BASE_MU_G = 0.11;
const float BASE_SIGMA_G = 0.0135;

void main() {
  vec2 gridSize = vec2(u_gridWidth, u_gridHeight);
  vec2 cell = floor(gl_FragCoord.xy);
  float sum = 0.0;
  for (float dy = -R; dy <= R; dy += 1.0) {
    for (float dx = -R; dx <= R; dx += 1.0) {
      vec2 kUV = (vec2(dx, dy) + R + 0.5) / KERNEL_SIZE;
      float k = texture2D(u_kernel, kUV).r;
      if (k == 0.0) continue;
      vec2 nc = mod(cell + vec2(dx, dy), gridSize);
      sum += k * texture2D(u_state, (nc + 0.5) / gridSize).r;
    }
  }

  float MU_G = BASE_MU_G + 0.06 * abs(sin(u_time * 0.15));
  float SIGMA_G = BASE_SIGMA_G;

  float u = sum / u_kernelNorm;
  float g = 2.0 * exp(-(u - MU_G) * (u - MU_G) / (2.0 * SIGMA_G * SIGMA_G)) - 1.0;

  vec2 selfUV = (cell + 0.5) / gridSize;
  float current = texture2D(u_state, selfUV).r;
  float occ = texture2D(u_state, selfUV).g;
  float next = clamp(current + DT * g, 0.0, 1.0);

  float mDist = length(mod(cell - u_mouse.xy + gridSize * 0.5, gridSize) - gridSize * 0.5);
  float mH1 = fract(sin(dot(cell, vec2(37.1, 159.7)) + u_time * 53.4) * 43758.5453);
  float mH2 = fract(sin(dot(cell, vec2(91.3, 247.9)) + u_time * 71.2) * 43758.5453);
  float mNoise = sqrt(-2.0 * log(max(mH1, 1e-6))) * cos(6.2831853 * mH2);
  float mFalloff = exp(-mDist * mDist / 200.0);
  next = clamp(next + u_mouse.z * mFalloff * mNoise * 0.4, 0.0, 1.0);

  float newOcc = mix(occ, next, 0.03);
  gl_FragColor = vec4(next, newOcc, 0.0, 1.0);
}
"""

DISP = """
#version 120
uniform vec2 u_resolution;
uniform float u_gridWidth;
uniform float u_gridHeight;
uniform float u_scrollCells;
uniform sampler2D u_state;
uniform vec3 u_colorCur;
uniform vec3 u_colorOcc;

void main() {
  float cellPx = u_resolution.x / u_gridWidth;
  vec2 cellCoord = gl_FragCoord.xy / cellPx;
  vec2 cell = floor(cellCoord);
  vec2 f = fract(cellCoord) - 0.5;

  vec2 scrolledCell = vec2(cell.x, mod(cell.y + u_scrollCells, u_gridHeight));
  vec2 uv = (scrolledCell + 0.5) / vec2(u_gridWidth, u_gridHeight);
  vec4 s = texture2D(u_state, uv);
  float cur = smoothstep(0.05, 0.9, s.r);
  float occ = smoothstep(0.05, 0.9, s.g);
  vec3 color = cur * u_colorCur + occ * u_colorOcc;
  gl_FragColor = vec4(color, 1.0);
}
"""

BLEND = """
#version 120
uniform sampler2D u_cur;
uniform sampler2D u_prev;
uniform float u_blend;
uniform vec2 u_gridSize;
void main() {
  vec2 uv = gl_FragCoord.xy / u_gridSize;
  vec4 c = texture2D(u_cur, uv);
  vec4 p = texture2D(u_prev, uv);
  gl_FragColor = mix(c, p, u_blend);
}
"""

# ── Build programs ──
sim_prog   = create_program(VERT, SIM)
disp_prog  = create_program(VERT, DISP)
blend_prog = create_program(VERT, BLEND)

def uloc(prog, name): return glGetUniformLocation(prog, name)
def aloc(prog, name): return glGetAttribLocation(prog, name)

# ── Geometry — single triangle covering clip space ──
vbo = glGenBuffers(1)
glBindBuffer(GL_ARRAY_BUFFER, vbo)
import array
glBufferData(GL_ARRAY_BUFFER, array.array('f', [-1,-1, 3,-1, -1,3]).tobytes(), GL_STATIC_DRAW)

# ── Texture helpers ──
def make_tex(w, h, data=None):
    tex = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, tex)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA32F, w, h, 0, GL_RGBA, GL_FLOAT, data)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
    return tex

def make_fbo(tex):
    fbo = glGenFramebuffers(1)
    glBindFramebuffer(GL_FRAMEBUFFER, fbo)
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, tex, 0)
    st = glCheckFramebufferStatus(GL_FRAMEBUFFER)
    if st != GL_FRAMEBUFFER_COMPLETE:
        raise RuntimeError(f"FBO incomplete: {st}")
    glBindFramebuffer(GL_FRAMEBUFFER, 0)
    return fbo

# ── Init state ──
init_data = array.array('f', [0.0] * (GRID_W * GRID_H * 4))
for i in range(GRID_W * GRID_H):
    init_data[i * 4] = random.random()

texA = make_tex(GRID_W, GRID_H, init_data.tobytes())
texB = make_tex(GRID_W, GRID_H)
fboA = make_fbo(texA)
fboB = make_fbo(texB)

# ── Kernel texture ──
K_SIZE = 31
K_R = 15.0
MU_K = 0.5
SIGMA_K = 0.13
kernel_data = array.array('f', [0.0] * (K_SIZE * K_SIZE * 4))
kernel_norm = 0.0
for y in range(K_SIZE):
    for x in range(K_SIZE):
        dx, dy = x - K_R, y - K_R
        r = max(abs(dx), abs(dy)) / K_R
        k = 0.0
        if r <= 1.0:
            k = math.exp(-(r - MU_K)**2 / (2 * SIGMA_K**2))
            kernel_norm += k
        kernel_data[(y * K_SIZE + x) * 4] = k
kernel_tex = make_tex(K_SIZE, K_SIZE, kernel_data.tobytes())

# ── Smooth textures ──
texSmA = make_tex(GRID_W, GRID_H)
texSmB = make_tex(GRID_W, GRID_H)
fboSmA = make_fbo(texSmA)
fboSmB = make_fbo(texSmB)

ping = 0
smooth_ping = 0

def draw(a_pos):
    glEnableVertexAttribArray(a_pos)
    glVertexAttribPointer(a_pos, 2, GL_FLOAT, False, 0, None)
    glDrawArrays(GL_TRIANGLES, 0, 3)

# ── Handle SIGTERM gracefully ──
running = True
def on_signal(sig, frame):
    global running
    running = False
signal.signal(signal.SIGTERM, on_signal)
signal.signal(signal.SIGINT, on_signal)

# ── Render loop ──
t0 = time.monotonic()
print("lock-saver: entering render loop", file=sys.stderr)

while running:
    t = (time.monotonic() - t0) * 1000.0  # ms

    # Sim passes
    glUseProgram(sim_prog)
    glViewport(0, 0, GRID_W, GRID_H)
    glUniform1f(uloc(sim_prog, "u_gridWidth"), GRID_W)
    glUniform1f(uloc(sim_prog, "u_gridHeight"), GRID_H)
    glUniform1f(uloc(sim_prog, "u_time"), t * 0.003)
    glUniform3f(uloc(sim_prog, "u_mouse"), 0, 0, 0)
    glUniform1f(uloc(sim_prog, "u_kernelNorm"), kernel_norm)
    glActiveTexture(GL_TEXTURE1)
    glBindTexture(GL_TEXTURE_2D, kernel_tex)
    glUniform1i(uloc(sim_prog, "u_kernel"), 1)

    for _ in range(SIM_STEPS):
        rd = texA if ping == 0 else texB
        wr = fboB if ping == 0 else fboA
        glBindFramebuffer(GL_FRAMEBUFFER, wr)
        glActiveTexture(GL_TEXTURE0)
        glBindTexture(GL_TEXTURE_2D, rd)
        glUniform1i(uloc(sim_prog, "u_state"), 0)
        draw(aloc(sim_prog, "a_pos"))
        ping = 1 - ping

    # Blend pass
    sim_tex = texA if ping == 0 else texB
    rd_sm   = texSmA if smooth_ping == 0 else texSmB
    wr_sm   = fboSmB if smooth_ping == 0 else fboSmA
    out_sm  = texSmB if smooth_ping == 0 else texSmA

    glUseProgram(blend_prog)
    glViewport(0, 0, GRID_W, GRID_H)
    glBindFramebuffer(GL_FRAMEBUFFER, wr_sm)
    glActiveTexture(GL_TEXTURE0)
    glBindTexture(GL_TEXTURE_2D, sim_tex)
    glActiveTexture(GL_TEXTURE1)
    glBindTexture(GL_TEXTURE_2D, rd_sm)
    glUniform1i(uloc(blend_prog, "u_cur"), 0)
    glUniform1i(uloc(blend_prog, "u_prev"), 1)
    glUniform1f(uloc(blend_prog, "u_blend"), TEMPORAL_BLEND)
    glUniform2f(uloc(blend_prog, "u_gridSize"), GRID_W, GRID_H)
    draw(aloc(blend_prog, "a_pos"))
    smooth_ping = 1 - smooth_ping

    # Display pass
    glUseProgram(disp_prog)
    glViewport(0, 0, W, H)
    glBindFramebuffer(GL_FRAMEBUFFER, 0)
    glActiveTexture(GL_TEXTURE0)
    glBindTexture(GL_TEXTURE_2D, out_sm)
    glUniform1i(uloc(disp_prog, "u_state"), 0)
    glUniform2f(uloc(disp_prog, "u_resolution"), W, H)
    glUniform1f(uloc(disp_prog, "u_gridWidth"), GRID_W)
    glUniform1f(uloc(disp_prog, "u_gridHeight"), GRID_H)
    glUniform1f(uloc(disp_prog, "u_scrollCells"), 0.0)
    glUniform3f(uloc(disp_prog, "u_colorCur"), *COLOR_CUR)
    glUniform3f(uloc(disp_prog, "u_colorOcc"), *COLOR_OCC)
    draw(aloc(disp_prog, "a_pos"))

    GL.glXSwapBuffers(dpy, xid)
    time.sleep(1/30)  # ~30 fps cap
