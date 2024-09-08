return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'haskell', 'rust', 'swift' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      }
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {
  --     enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
  --     max_lines = 3,        -- How many lines the window should span. Values <= 0 mean no limit.
  --     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  --     line_numbers = true,
  --     multiline_threshold = 20, -- Maximum number of lines to show for a single context
  --     trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  --     mode = 'cursor',      -- Line used to calculate context. Choices: 'cursor', 'topline'
  --     -- Separator between context and content. Should be a single character string, like '-'.
  --     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  --     separator = nil,
  --     zindex = 20, -- The Z-index of the context window
  --     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  --   },
  -- }
}
