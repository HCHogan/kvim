return {
  -- {
  --   "nvimdev/guard.nvim",
  --   event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  -- },
  {
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection"
    },
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
      vim.g.guard_config = {
        -- format on write to buffer
        fmt_on_save = true,
        -- use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = true,
        -- whether or not to save the buffer after formatting
        save_on_fmt = true,
        -- automatic linting
        auto_lint = true,
        -- how frequently can linters be called
        lint_interval = 500
      }

      local ft = require('guard.filetype')

      ft('swift'):fmt('swiftformat') -- :lint('swiftlint')
      -- ft('typst'):fmt('typstyle')
      ft('json'):fmt('biome')
      ft('css'):fmt('biome')
      -- ft('nix'):fmt('alejandra')
      ft('markdown'):fmt('prettierd')
      ft('hasekll'):lint('hlint')
    end,
    keys = {
      { "<leader>lf", "<cmd>Guard fmt<CR>", desc = "format buffer" }
    }
  },
}
