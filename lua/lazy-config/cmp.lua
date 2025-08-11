local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

return {
  {
    'saghen/blink.cmp',
    event = "BufReadPost",
    -- optional: provides snippets for the snippet source
    dependencies = {
      {
        'saghen/blink.compat',
        -- use v2.* for blink.cmp v1.*
        version = '2.*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
      },
      'HCHogan/cmp-agda-symbols',
      'rafamadriz/friendly-snippets',
      'moyiz/blink-emoji.nvim',
      -- "4e554c4c/blink-cmp-agda-symbols",
    },

    version = '^1',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<M-S-n>"] = { "snippet_backward" },
        ["<M-n>"] = { "snippet_forward" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-N>"] = { "select_next", "show" },
        ["<C-P>"] = { "select_prev", "show" },
        ["<C-J>"] = { "select_next", "fallback" },
        ["<C-K>"] = { "select_prev", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function(cmp)
            if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          function(cmp)
            if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          auto_show = function(ctx) return ctx.mode ~= "cmdline" end,
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            treesitter = { "lsp" },
            components = {
              -- customize the drawing of kind icons
              kind_icon = {
                text = function(ctx)
                  -- default kind icon
                  local icon = ctx.kind_icon
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                    local color_item = require("nvim-highlight-colors").format(ctx.item.documentation,
                      { kind = ctx.kind })
                    if color_item and color_item.abbr ~= "" then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  -- default highlight group
                  local highlight = "BlinkCmpKind" .. ctx.kind
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                    local color_item = require("nvim-highlight-colors").format(ctx.item.documentation,
                      { kind = ctx.kind })
                    if color_item and color_item.abbr_hl_group then
                      highlight = color_item.abbr_hl_group
                    end
                  end
                  return highlight
                end,
              },
            },
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
      },
      signature = {
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'mooncake', 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
        per_filetype = {
          agda = { inherit_defaults = true, 'agda_symbols' }
        },
        providers = {
          agda_symbols = {
            name = "agda-symbols",
            module = 'blink.compat.source',
          },
          mooncake = {
            name   = 'Mooncakes',
            module = 'moonbit.mooncakes.completion.blink',
            opts   = { max_items = 100 },
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = {
              insert = true,   -- Insert emoji (default) or complete its name
              ---@type string|table|fun():table
              trigger = function()
                return { ":" }
              end,
            },
            should_show_items = function()
              return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          }
        }
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
    },
    opts_extend = { "sources.default" }
  }
}
