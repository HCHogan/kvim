-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo" },
    dependencies = {
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
      'nvimdev/lspsaga.nvim',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.lspsaga
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', '<CMD>Lspsaga goto_definition<CR>', 'goto definition')
          map('gi', '<CMD>Lspsaga finder imp<CR>', 'goto implementation')
          map('gr', '<cmd>Lspsaga finder<CR>', 'Search references')
          map('gp', '<cmd>Lspsaga peek_definition<CR>', 'Peek definition')
          map('gtp', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type definition')
          map('gtd', '<cmd>Lspsaga goto_type_definition<CR>', 'Type definition')

          map('[d', '<CMD>Lspsaga diagnostic_jump_prev<CR>', 'jump to previous diagnostics')
          map(']d', '<CMD>Lspsaga diagnostic_jump_next<CR>', 'jump to next diagnostics')

          map('K', '<CMD>Lspsaga hover_doc<CR>', 'show doc')

          map('<leader>lc', '<cmd>Lspsaga incoming_calls<CR>', 'Incoming calls')
          map('<leader>lC', '<cmd>Lspsaga outgoing_calls<CR>', 'Outgoing calls')
          map('<leader>la', '<cmd>Lspsaga code_action<CR>', 'LSP code action')
          map('<leader>lS', '<cmd>Lspsaga outline<CR>', 'Symbols outline')
          map('<leader>lr', '<cmd>Lspsaga rename<CR>', 'Symbols rename')
          map('<leader>ld', function()
            vim.diagnostic.open_float()
          end, 'Hover diagnostic')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uH', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- :h lspconfig-all
      local lspconfig = require 'lspconfig'
      lspconfig['lua_ls'].setup {}
      lspconfig['basedpyright'].setup {}
      lspconfig['clangd'].setup {
        -- cmd = { '/opt/homebrew/opt/llvm/bin/clangd' },
        capabilities = {
          offsetEncoding = 'utf-8',
        },
      }
      lspconfig['sourcekit'].setup {
        filetypes = { 'swift' },
        on_init = function(client)
          -- HACK: to fix some issues with LSP
          -- more details: https://github.com/neovim/neovim/issues/19237#issuecomment-2237037154
          client.offset_encoding = 'utf-8'
        end,
      }
      lspconfig['tinymist'].setup {}
      lspconfig['marksman'].setup {}
      lspconfig['bashls'].setup {}
      lspconfig['svls'].setup {}
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    -- version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'mrcjkb/haskell-tools.nvim',
    -- version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },

    -- see details below for full configuration options
    opts = {
      lsp = {},
      mappings = true,
      infoview = {
        width = 40,
      }
    }
  },
  {
    'wojciech-kulik/xcodebuild.nvim',
    lazy = true,
    event = 'BufEnter *.swift',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter', -- (optional) for Quick tests support (required Swift parser)
    },
    config = function()
      local uv = vim.loop
      -- Function to check if a directory exists
      local function directory_exists(path)
        local stat = uv.fs_stat(path)
        return stat and stat.type == "directory"
      end

      -- Function to check for .xcodeproj or .xcworkspace directories in the current working directory
      local function has_xcode_files()
        local current_dir = uv.cwd()
        local dir = uv.fs_opendir(current_dir, nil, 100)
        if dir then
          while true do
            local entries = uv.fs_readdir(dir)
            if not entries then break end
            for _, entry in ipairs(entries) do
              if
                  (entry.name:match "%.xcodeproj$" or entry.name:match "%.xcworkspace$") and entry.type == "directory"
              then
                uv.fs_closedir(dir)
                return true
              end
            end
          end
          uv.fs_closedir(dir)
        end
        return false
      end

      if not has_xcode_files() then return end
      require('xcodebuild').setup {}
      vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show Xcodebuild Actions' })
      vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', { desc = 'Show Project Manager Actions' })

      vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
      vim.keymap.set('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = 'Build For Testing' })
      vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })

      vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
      vim.keymap.set('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })
      vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run Current Test Class' })
      vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Repeat Last Test Run' })

      vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
      vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
      vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>',
        { desc = 'Show Code Coverage Report' })
      vim.keymap.set('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Toggle Test Explorer' })
      vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show Failing Snapshots' })

      vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
      vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test Plan' })
      vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })

      vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildQuickfixLine<cr>', { desc = 'Quickfix Line' })
      vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', { desc = 'Show Code Actions' })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'BufReadPost',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true, -- TODO: copilot-cmp
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true, -- TODO: copilot-cmp
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-;>',
            accept_word = false,
            accept_line = "<M-'>",
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    config = function()
      vim.keymap.set('n', '<F7>', "<cmd>Lspsaga term_toggle<CR>", { desc = 'Toggle terminal' })
      require('lspsaga').setup {
        finder = {
          keys = {
            toggle_or_open = '<CR>',
            quit = { 'q', '<ESC>' },
          }
        },
        diagnostic = {
          keys = {
            quit = { 'q', '<ESC>' },
          },
        },
      }
    end,
  },
  -- {
  --   'Wansmer/symbol-usage.nvim',
  --   event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
  --   config = function()
  --     local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end
  --
  --     -- hl-groups can have any name
  --     vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
  --     vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
  --     vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
  --     vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
  --     vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })
  --
  --     local function text_format(symbol)
  --       local res = {}
  --
  --       local round_start = { '', 'SymbolUsageRounding' }
  --       local round_end = { '', 'SymbolUsageRounding' }
  --
  --       -- Indicator that shows if there are any other symbols in the same line
  --       local stacked_functions_content = symbol.stacked_count > 0
  --           and ("+%s"):format(symbol.stacked_count)
  --           or ''
  --
  --       if symbol.references then
  --         local usage = symbol.references <= 1 and 'usage' or 'usages'
  --         local num = symbol.references == 0 and 'no' or symbol.references
  --         table.insert(res, round_start)
  --         table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
  --         table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
  --         table.insert(res, round_end)
  --       end
  --
  --       if symbol.definition then
  --         if #res > 0 then
  --           table.insert(res, { ' ', 'NonText' })
  --         end
  --         table.insert(res, round_start)
  --         table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
  --         table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
  --         table.insert(res, round_end)
  --       end
  --
  --       if symbol.implementation then
  --         if #res > 0 then
  --           table.insert(res, { ' ', 'NonText' })
  --         end
  --         table.insert(res, round_start)
  --         table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
  --         table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
  --         table.insert(res, round_end)
  --       end
  --
  --       if stacked_functions_content ~= '' then
  --         if #res > 0 then
  --           table.insert(res, { ' ', 'NonText' })
  --         end
  --         table.insert(res, round_start)
  --         table.insert(res, { ' ', 'SymbolUsageImpl' })
  --         table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
  --         table.insert(res, round_end)
  --       end
  --
  --       return res
  --     end
  --
  --     require('symbol-usage').setup({
  --       text_format = text_format,
  --     })
  --   end
  -- }
}
