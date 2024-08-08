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

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'NeoTree toggle' })

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

-- builtin toggle comment
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'Toggle comment line' })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Toggle comment line' })

-- set indent
vim.keymap.set('n', '<leader>ui', function()
  local input_avail, input = pcall(vim.fn.input, 'Set indent value (>0 expandtab, <=0 noexpandtab): ')
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then
      return
    end
    vim.bo.expandtab = (indent > 0) -- local to buffer
    indent = math.abs(indent)
    vim.bo.tabstop = indent -- local to buffer
    vim.bo.softtabstop = indent -- local to buffer
    vim.bo.shiftwidth = indent -- local to buffer
  end
end)
