local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set textwidth for .tex files
autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.textwidth = 120
  end,
})
