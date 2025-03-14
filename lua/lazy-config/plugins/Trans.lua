return {
  "JuanZoran/Trans.nvim",
  enabled = true,
  dependencies = {
    "kkharji/sqlite.lua",
  },
  event = "VeryLazy",
  keys = {
    { "<Leader>lt", "<Cmd>Translate<CR>", mode = { "n", "x" }, desc = "Translate" }
  },
  opts = {
    frontend = {
      default = {
        animation = {
          open = false,
          close = false,
        }
      },
      hover = {
        width = 42,
      }
    }
  }
}
