-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ']b', '<cmd>BufferNext<CR>')
vim.keymap.set('n', '[b', '<cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<leader>c', '<cmd>BufferClose<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>')
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('v', 'J', '5j')
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- lspsafa
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', { desc = 'Hover symbol details' })
vim.keymap.set('n', '<leader>lc', '<cmd>Lspsaga incoming_calls<CR>', { desc = 'Incoming calls' })
vim.keymap.set('n', '<leader>lC', '<cmd>Lspsaga outgoing_calls<CR>', { desc = 'Outgoing calls' })
vim.keymap.set('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', { desc = 'LSP code action' })
vim.keymap.set('x', '<leader>a', '<cmd>Lspsaga code_action<CR>', { desc = 'LSP code action' })
vim.keymap.set('n', '<leader>lp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition' })
vim.keymap.set('n', '<leader>lS', '<cmd>Lspsaga outline<CR>', { desc = 'Symbols outline' })
vim.keymap.set('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', { desc = 'Symbols rename' })
vim.keymap.set('n', '<leader>lR', '<cmd>Lspsaga finder<CR>', { desc = 'Search references' })
