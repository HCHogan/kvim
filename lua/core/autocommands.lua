-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- fix cursor in windows terminal
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.o.guicursor = ""
    vim.fn.chansend(vim.v.stderr, "\x1b[ q]")
  end,
})

-- We have no BH treesitter, so we have to make do with hs's treesitter
vim.filetype.add({
  extension = {
    bs = "haskell",
  }
})
