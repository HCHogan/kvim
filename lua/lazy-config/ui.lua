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
      -- …etc.
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
    event = "VeryLazy",
    opts = function()
      local lib = require "heirline-components.all"
      return {
        opts = {
          disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
            local is_disabled = not require("heirline-components.buffer").is_valid(args.buf) or
                lib.condition.buffer_matches({
                  buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                  filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
                }, args.buf)
            return is_disabled
          end,
          disable_statusline_cb = function(args)
            local is_disabled = not require("heirline-components.buffer").is_valid(args.buf) or
                lib.condition.buffer_matches({
                  buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                  filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial", "avante" },
                }, args.buf)
            return is_disabled
          end,
        },
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
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        term_colors = true,
        integrations = {
          flash = true,
          noice = true,
          neotree = true,
          treesitter = true,
          which_key = true,
          lsp_saga = true,
          dropbar = {
            enabled = true,
            color_mode = true,
          },
          dap = true,
          dap_ui = true,
          barbar = true,
          snacks = true,
          blink_cmp = true,
        },
      }
      vim.cmd "colorscheme catppuccin"
    end,
  },
  -- { "nvzone/volt",              lazy = true },
  -- { "nvzone/menu",              lazy = true },
  -- {
  --   "nvzone/minty",
  --   cmd = { "Shades", "Huefy" },
  -- },
}
