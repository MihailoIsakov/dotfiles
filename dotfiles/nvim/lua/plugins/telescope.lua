return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = '[?] Find recently opened files' },
      { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = '[ ] Find existing buffers' },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[/] Fuzzily search in current buffer',
      },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
      {
        '<leader>fg',
        function()
          require('telescope').extensions.live_grep_args.live_grep_args()
        end,
        desc = '[F]ind by [G]rep',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable('make') == 1,
      },
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')
      require('telescope').load_extension('live_grep_args')
    end,
  },
}
