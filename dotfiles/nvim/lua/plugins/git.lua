return {
  { 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gdiff' } },
  { 'tpope/vim-rhubarb', dependencies = { 'tpope/vim-fugitive' } },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 300,
      },
    },
  },
}
