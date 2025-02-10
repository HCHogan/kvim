return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'haskell',
        'rust',
        'swift',
        'python',
        'yaml',
        'javascript',
        'typescript',
        "css",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<enter>",
          node_incremental = "<enter>",
          scope_incremental = false,
          node_decremental = "<bs>",
        }
      },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",
            ["l="] = "@assignment.lhs",
            ["r="] = "@assignment.rhs",

            ["a,"] = "@parameter.outer",
            ["i,"] = "@parameter.inner",

            ["a;"] = "@statement.outer",
            ["i;"] = "@statement.inner",

            ["a\""] = "@string.outer",
            ["i\""] = "@string.inner",

            ["a?"] = "@conditional.outer",
            ["i?"] = "@conditional.inner",

            ["afd"] = "@function.outer",
            ["ifd"] = "@function.inner",
            ["afc"] = "@call.outer",
            ["ifc"] = "@call.inner",

            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",

            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>s"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>S"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["[c"] = "@call.outer",
            ["]?"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
            ["];"] = "@statement.outer",
            ["]a"] = "@assignment.outer",
            ["],"] = "@parameter.outer",
            ["]\""] = "@string.outer",
            -- ["]s"] = "@scope",
            -- ["]z"] = "@fold",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@call.outer",
            -- ["]?"] = "@conditional.outer",
            ["]L"] = "@loop.outer",
            -- ["];"] = "@statement.outer",
            ["]A"] = "@assignment.outer",
            -- ["],"] = "@parameter.outer",
            ["]\""] = "@string.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@call.outer",
            ["[?"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
            ["[;"] = "@statement.outer",
            ["[a"] = "@assignment.outer",
            ["[,"] = "@parameter.outer",
            ["[\""] = "@string.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@call.outer",
            -- ["[?"] = "@conditional.outer",
            ["[L"] = "@loop.outer",
            -- ["[;"] = "@statement.outer",
            ["[A"] = "@assignment.outer",
            -- ["[,"] = "@parameter.outer",
            ["[\""] = "@string.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            ["]f"] = "@conditional.outer",
          },
          goto_previous = {
            ["[f"] = "@conditional.outer",
          }
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  }
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
