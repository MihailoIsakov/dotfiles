-- Set leader keys BEFORE lazy.nvim loads (critical for correct mappings)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core settings
require('core.options')
require('core.keymaps')
require('core.autocmds')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'onedark' } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
