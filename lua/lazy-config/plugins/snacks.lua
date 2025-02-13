return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
    },
    image = {
      enabled = true,
    },
    picker = {
      enabled = true,
      ui_select = true,
    },
  },
  keys = {
    { "<leader>f<space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
    { "<leader>ff",       function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fw",       function() Snacks.picker.grep() end,  desc = "Find files" },
  }
}
