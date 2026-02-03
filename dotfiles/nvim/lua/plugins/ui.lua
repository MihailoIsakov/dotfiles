return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      local c = require('onedark.colors')
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = '|',
          section_separators = ' ',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'diff',
              diff_color = {
                added = { fg = '#99c794' },
                modified = { fg = '#5bb7b8' },
                removed = { fg = '#ec5f67' },
              },
            },
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              sections = { 'error', 'warn', 'info', 'hint' },
              diagnostics_color = {
                error = 'DiagnosticError',
                warn = 'DiagnosticWarn',
                info = 'DiagnosticInfo',
                hint = 'DiagnosticHint',
              },
              symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            },
          },
          lualine_c = {
            {
              'buffers',
              show_filename_only = true,
              hide_filename_extension = false,
              show_modified_status = true,
              mode = 0,
              max_length = vim.o.columns * 2 / 3,
              filetype_names = {
                TelescopePrompt = 'Telescope',
                dashboard = 'Dashboard',
                lazy = 'Lazy',
                fzf = 'FZF',
                alpha = 'Alpha',
              },
              buffers_color = {
                active = { fg = c.orange, bg = c.bg0, gui = 'bold' },
              },
              symbols = {
                modified = ' ●',
                alternate_file = '#',
                directory = '',
              },
            },
          },
        },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
}
