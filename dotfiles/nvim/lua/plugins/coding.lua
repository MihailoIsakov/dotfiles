return {
  {
    'github/copilot.vim',
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        comments_only = false,
        keyword = 'bg',
      },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FB8524' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
        green = { 'Good', '#478f4d' },
      },
      merge_keywords = true,
      keywords = {
        TODO = { icon = '', color = 'info' },
        FIXME = { icon = '󰈸', color = 'error' },
        BUG = { icon = '󰈸', color = 'error' },
        FIX = { icon = '󰈸', color = 'error' },
        ERROR = { icon = '', color = 'error' },
        WARN = { icon = '󰗖', color = 'warning', alt = { 'WARNING', 'XXX' } },
        HACK = { icon = '󰂓', color = 'error' },
        TEST = { icon = '󰂓', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        PERF = { icon = '󰈸', color = 'warning', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = '🗒', color = 'green', alt = { 'INFO' } },
        IDEA = { icon = '', color = 'green' },
      },
    },
  },
}
