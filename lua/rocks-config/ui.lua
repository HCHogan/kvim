-- barbar
vim.g.barbar_auto_setup = false
require('barbar').setup {
  animation = true,
  insert_at_start = false,
}

require('rose-pine').setup {
  variant = 'auto', -- auto, main, moon, or dawn
  dark_variant = 'main', -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true, -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = false,
    transparency = false,
  },

  groups = {
    border = 'muted',
    link = 'iris',
    panel = 'surface',

    error = 'love',
    hint = 'iris',
    info = 'foam',
    note = 'pine',
    todo = 'rose',
    warn = 'gold',

    git_add = 'foam',
    git_change = 'rose',
    git_delete = 'love',
    git_dirty = 'rose',
    git_ignore = 'muted',
    git_merge = 'iris',
    git_rename = 'pine',
    git_stage = 'iris',
    git_text = 'rose',
    git_untracked = 'subtle',

    h1 = 'iris',
    h2 = 'foam',
    h3 = 'rose',
    h4 = 'gold',
    h5 = 'pine',
    h6 = 'foam',
  },

  highlight_groups = {
    Comment = { italic = true },
    -- VertSplit = { fg = "muted", bg = "muted" },
    -- EndOfBuffer = { fg = 'rose' },
    -- Function = { italic = true },
  },

  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
}

vim.cmd 'colorscheme rose-pine'

-- below is trash
return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    event = 'BufReadPost',
  },
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
