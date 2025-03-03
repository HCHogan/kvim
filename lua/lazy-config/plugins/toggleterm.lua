return {
  'akinsho/nvim-toggleterm.lua',
  event = 'VeryLazy',
  opts = {
    size = 10,
    on_create = function(t)
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.signcolumn = "no"
      if t.hidden then
        local function toggle() t:toggle() end
        vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
      end
    end,
    shading_factor = 2,
    float_opts = { border = "rounded" },
  },
  cmd = 'ToggleTerm',
}
