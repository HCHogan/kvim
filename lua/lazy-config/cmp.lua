local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

-- local function get_kind_icon(CTX)
--   local lspkind = require("lspkind")
--   if CTX.item.source_name == "LSP" then
--     local icon = lspkind.symbolic(CTX.kind, { mode = "symbol" })
--     if icon then CTX.kind_icon = icon end
--   end
--   return { text = CTX.kind_icon .. CTX.icon_gap, highlight = CTX.kind_hl }
-- end
-- {
--   "onsails/lspkind-nvim",
--   opts = {
--     mode = "symbol",
--     symbol_map = {
--       Array = "󰅪",
--       Boolean = "⊨",
--       Class = "󰌗",
--       Constructor = "",
--       Key = "󰌆",
--       Namespace = "󰅪",
--       Null = "NULL",
--       Number = "#",
--       Object = "󰀚",
--       Package = "󰏗",
--       Property = "",
--       Reference = "",
--       Snippet = "",
--       String = "󰀬",
--       TypeParameter = "󰊄",
--       Unit = "",
--     },
--     menu = {},
--   },
-- },

return {
  {
    'saghen/blink.cmp',
    event = "VeryLazy",
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
    },

    version = '^1',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
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
            -- components = {
            --   kind_icon = {
            --     text = function(ctx) return get_kind_icon(ctx).text end,
            --     highlight = function(ctx) return get_kind_icon(ctx).highlight end,
            --   },
            -- },
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
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = { completion = { ghost_text = { enabled = false } } },
    },
    opts_extend = { "sources.default" }
  }
}
