return {
  {
    'romgrk/barbar.nvim',
    event = 'BufReadPost',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = false,
      insert_at_start = false,
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
    event = "BufReadPost",
    opts = function()
      local lib = require "heirline-components.all"
      return {
        statusline = { -- UI statusbar
          hl = { fg = "fg", bg = "bg" },
          lib.component.mode(),
          lib.component.git_branch(),
          lib.component.file_info(),
          lib.component.git_diff(),
          lib.component.diagnostics(),
          lib.component.fill(),
          lib.component.cmd_info(),
          lib.component.fill(),
          lib.component.lsp(),
          lib.component.compiler_state(),
          lib.component.virtual_env(),
          lib.component.nav(),
          lib.component.mode { surround = { separator = "right" } },
        },
      }
    end,
    config = function(_, opts)
      local heirline = require "heirline"
      local lib = require "heirline-components.all"

      -- Setup
      lib.init.subscribe_to_events()
      heirline.load_colors(lib.hl.get_colors())
      heirline.setup(opts)
    end,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanso').setup {
        compile = true,
        transparent = false,
        keywordStyle = { italic = false, bold = true },
        theme = "zen",
        -- overrides = function(colors)
        --   return {
        --     WinSeparator = { fg = colors.theme.ui.ident_line, bold = false },
        --     SnacksPickerTitle = { fg = colors.theme.ui.fg, bold = false },
        --   }
        -- end,
      }
      vim.cmd("colorscheme kanso")
    end
  },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup {
  --       term_colors = true,
  --       integrations = {
  --         flash = true,
  --         noice = true,
  --         neotree = true,
  --         treesitter = true,
  --         which_key = true,
  --         lsp_saga = true,
  --         gitsigns = true,
  --         dropbar = {
  --           enabled = true,
  --           color_mode = false,
  --         },
  --         dap = true,
  --         dap_ui = true,
  --         barbar = true,
  --         snacks = {
  --           enabled = true,
  --         },
  --         blink_cmp = true,
  --       },
  --     }
  --     vim.cmd "colorscheme catppuccin"
  --   end,
  -- },
  -- { "nvzone/volt",              lazy = true },
  -- { "nvzone/menu",              lazy = true },
  -- {
  --   "nvzone/minty",
  --   cmd = { "Shades", "Huefy" },
  -- },
}
