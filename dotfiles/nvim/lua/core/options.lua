-- Appearance
vim.o.termguicolors = true
vim.wo.number = true
vim.o.cursorline = true
vim.opt.colorcolumn = '120'
vim.wo.signcolumn = 'number'
vim.opt.signcolumn = 'number'

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Editing
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.opt.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'

-- Tabs/Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

-- Folding (for UFO)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Performance
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 250
vim.o.updatetime = 250

-- Completion
vim.opt.wildmode = 'list:longest'

-- Which-key timeout
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
