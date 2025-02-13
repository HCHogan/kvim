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
    input = {
      enabled = true,
    },
    lazygit = {
      enabled = true,
    },
    indent = {
      enabled = true,
    },
  },
  keys = {
    { "<leader>f<space>", function() require('snacks').picker.smart() end, desc = "Smart find files" },
    { "<leader>ff",       function() require('snacks').picker.files() end, desc = "Find files" },
    { "<leader>fw",       function() require('snacks').picker.grep() end,  desc = "Grep files" },
    { "<leader>g",        function() require('snacks').lazygit() end,      desc = "Lazygit" },
  }
}
