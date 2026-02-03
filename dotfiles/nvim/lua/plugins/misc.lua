return {
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('colorizer').setup()
    end,
  },
  { 'jbyuki/venn.nvim', cmd = 'VBox' },
  { 'preservim/vim-markdown', ft = 'markdown' },
}
