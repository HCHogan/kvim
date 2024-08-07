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
    event = 'BufEnter',
    dependencies = {
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
      'nvimdev/lspsaga.nvim',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
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
          -- map('<leader>lf', function()
          --   vim.lsp.buf.format()
          -- end, 'Format buffer')

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
        cmd = { '/opt/homebrew/opt/llvm/bin/clangd' },
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
      lspconfig['tinymist'].setup{}
      lspconfig['marksman'].setup{}
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
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
    event = 'VeryLazy',
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
      require('lspsaga').setup {
        diagnostic = {
          keys = {
            quit = { 'q', '<ESC>' },
          },
        },
      }
    end,
  },
}
