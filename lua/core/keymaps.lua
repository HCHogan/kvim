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
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('x', 'j', 'gj')
vim.keymap.set('x', 'k', 'gk')

vim.keymap.set('n', '<M-t>', function() require('snacks').terminal() end, {desc = 'Toggle terminal'})
vim.keymap.set('t', '<M-t>', function() require('snacks').terminal() end, {desc = 'Toggle terminal'})
-- vim.keymap.set('n', '<leader>th', function() require('snacks').terminal() end, {desc = 'Toggle terminal'})
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', {desc = 'Toggle file tree'})

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
vim.keymap.set('n', '<C-up>', function() require("smart-splits").resize_up() end,
  { desc = 'Resize split up' })
vim.keymap.set('n', '<C-down>', function() require("smart-splits").resize_down() end,
  { desc = 'Resize split down' })
vim.keymap.set('n', '<C-left>', function() require("smart-splits").resize_left() end,
  { desc = 'Resize split left' })
vim.keymap.set('n', '<C-right>', function() require("smart-splits").resize_right() end,
  { desc = 'Resize split right' })

-- builtin toggle comment
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = "Toggle comment line" })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = "Toggle comment" })

vim.keymap.set('n', "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
vim.keymap.set('n', "<Leader>q", "<Cmd>confirm q<CR>", { desc = "Quit Window" })
vim.keymap.set('n', "<Leader>Q", "<Cmd>confirm qall<CR>", { desc = "Exit" })
vim.keymap.set('n', "<Leader>n", "<Cmd>enew<CR>", { desc = "New File" })
vim.keymap.set('n', "<ESC>", "<Cmd>nohlsearch<CR>", { desc = "Clear Highlight" })
-- vim.keymap.set("n", "<leader>lf", "<cmd>Guard fmt<CR>")

-- debug
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = "Toogle breakpoint" })
vim.keymap.set('n', '<C-F9>', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = "Conditional breakpoint" })
vim.keymap.set('n', '<Leader>dr', function() require 'dap'.repl.open() end, { desc = "Repl open" })
vim.keymap.set('n', '<S-F9>', function() require('dap').run_last() end, { desc = "Run last" })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Continue" })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Step over" })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Step into" })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Step out" })

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
    vim.bo.tabstop = indent         -- local to buffer
    vim.bo.softtabstop = indent     -- local to buffer
    vim.bo.shiftwidth = indent      -- local to buffer
  end
end)

if vim.g.neovide then
  vim.keymap.set('n', 'C-N', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Neovide toggle fullscreen" })
end
