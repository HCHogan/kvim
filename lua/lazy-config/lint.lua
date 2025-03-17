return {
  -- {
  --   "nvimdev/guard.nvim",
  --   dependencies = {
  --     "nvimdev/guard-collection"
  --   },
  --   event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  --   config = function()
  --     vim.g.guard_config = {
  --       -- format on write to buffer
  --       fmt_on_save = true,
  --       -- use lsp if no formatter was defined for this filetype
  --       lsp_as_default_formatter = true,
  --       -- whether or not to save the buffer after formatting
  --       save_on_fmt = true,
  --       -- automatic linting
  --       auto_lint = true,
  --       -- how frequently can linters be called
  --       lint_interval = 500
  --     }
  --
  --     local ft = require('guard.filetype')
  --
  --     ft('swift'):fmt('swiftformat') -- :lint('swiftlint')
  --     -- ft('typst'):fmt('typstyle')
  --     ft('json'):fmt('biome')
  --     ft('css'):fmt('biome')
  --     -- ft('nix'):fmt('alejandra')
  --     ft('markdown'):fmt('prettierd')
  --     ft('hasekll'):lint('hlint')
  --   end,
  --   keys = {
  --     { "<leader>lf", "<cmd>Guard fmt<CR>", desc = "format buffer" }
  --   }
  -- },
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- markdown = { 'markdownlint' },
        swift = { 'swiftlint' },
        python = { 'ruff' },
        haskell = { 'hlint' }
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>lf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = false,
      formatters_by_ft = {
        swift = { 'swiftformat' },
        typst = { 'typstyle' },
        json = { 'biome' },
        css = { 'biome' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        nix = { 'alejandra' },
      },
    },
  },
}
