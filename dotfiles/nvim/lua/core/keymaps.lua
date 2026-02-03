local keymap = vim.keymap.set
local opts = { silent = true }

-- Disable space in normal/visual mode (leader key)
keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- DVORAK-like navigation remapping (j/k/l/; swapped)
keymap({ 'n', 'v' }, ';', 'l', opts)
keymap({ 'n', 'v' }, 'l', 'gk', opts)
keymap({ 'n', 'v' }, 'k', 'gj', opts)
keymap({ 'n', 'v' }, 'j', 'h', opts)

-- Search behavior
keymap('n', '*', 'g*``', {})
keymap('n', '#', 'g#``', {})
keymap('n', '<C-f>', '*', {})
keymap('n', '<C-c>', ':nohlsearch<CR>', {})
keymap('n', 'n', 'nzz', {})
keymap('n', 'N', 'Nzz', {})

-- Navigation
keymap('n', '<C-e>', '$', {})

-- Visual mode indentation (stay in visual mode)
keymap('v', '<', '<gv', {})
keymap('v', '>', '>gv', {})

-- Buffer navigation
keymap('n', '<C-n>', ':bn<CR>', {})
keymap('n', '<C-p>', ':bp<CR>', {})

-- Clipboard
keymap('v', '<F9>', '"*y :let @+=@*<CR>', { noremap = true, silent = true })
keymap('n', '<F10>', '"+p', { noremap = true, silent = true })

-- Diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '<leader>q', vim.diagnostic.setloclist)

-- Copilot accept
keymap('i', '<C-CR>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
