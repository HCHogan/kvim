return {
  {
    'romgrk/barbar.nvim',
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
    event = 'BufReadPost',
  },
  {
    'Bekaboo/dropbar.nvim',
    event = 'UIEnter',
    opts = {},
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    main = 'ibl',
    opts = {},
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
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
      -- local colors = require("catppuccin.palettes").get_palette "mocha"
      -- colors.none = "NONE"
      require("catppuccin").setup {
        transparent_background = false,
        styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = { "bold" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          flash = true,
          noice = true,
          neotree = true,
          treesitter = true,
          which_key = true,
          lsp_saga = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          dropbar = {
            enabled = true,
            color_mode = true,
          },
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          dap = true,
          barbar = true,
          aerial = true,
          headlines = true,
        },
      }
      vim.cmd "colorscheme catppuccin"
    end,
  },
}

-- {                  -- You can easily change to a different colorscheme.
--   'folke/tokyonight.nvim',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   init = function() end,
--   config = function()
--     require('tokyonight').setup({
--       styles = {
--         keywords = { italic = false, bold = true },
--         -- VertSplit = { fg = "muted", bg = "muted" },
--         -- EndOfBuffer = { fg = 'rose' },
--         -- Function = { italic = true },
--       },
--     })
--     -- vim.cmd 'colorscheme tokyonight-night'
--   end,
-- },
--
-- {
--   "goolord/alpha-nvim",
--   config = function ()
--     require'alpha'.setup(require'alpha.themes.dashboard'.config)
--   end
-- },
--
-- {
--   -- Calls `require('slimline').setup({})`
--   "sschleemilch/slimline.nvim",
--   opts = {
--     spaces = {
--       components = "",
--       left = "",
--       right = "",
--     },
--     sep = {
--       hide = {
--         first = true,
--         last = true,
--       },
--       left = "",
--       right = "",
--     },
--   }
-- },
