return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  -- event = 'BufReadPost',
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    file_selector = {
      provider = "snacks",
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",      -- for providers='copilot'
  },
}
