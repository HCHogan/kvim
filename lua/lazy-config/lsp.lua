-- LSP Plugins
return {
  {
    'mfussenegger/nvim-jdtls',
  },
  {
    'mrcjkb/rustaceanvim',
    -- version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      local cfg = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
                extraArgs = { "--profile", "rust-analyzer" },
              },
              checkOnSave = {
                command = "clippy",
                allTargets = false,
                extraArgs = { "--no-deps" },
                allFeatures = true,
              },
              -- inlayHints = {
              -- reborrowHints = {
              --   enable = "mutable",
              -- },
              -- lifetimeElisionHints = {
              --   enable = "skip_trivial",
              -- },
              -- closureReturnTypeHints = {
              --   enable = "with_block",
              -- },
              -- implicitDrops = {
              --   enable = "always",
              -- },
              -- discriminantHints = {
              --   enable = "always",
              -- },
              -- expressionAdjustmentHints = {
              --   enable = "always",
              --   hideOutsideUnsafe = false,
              --   mode = "prefix",
              -- },
              -- },
            },
          },
        },
        -- DAP configuration
        dap = {
        },
      }
      vim.g.rustaceanvim = cfg
    end,
  },
  {
    'mrcjkb/haskell-tools.nvim',
    -- version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'isovector/cornelis',
    name = 'cornelis',
    ft = 'agda',
    build = 'stack install',
    init = function()
      vim.g.cornelis_no_agda_input = true
    end,
    dependencies = { 'neovimhaskell/nvim-hs.vim', 'kana/vim-textobj-user' },
    version = '*',
    keys = {
      { '<C-c><C-l>', '<Cmd>CornelisLoad<CR>', desc = 'Cornelis: Load and type‑check buffer' },
      { '<C-c>?', '<Cmd>CornelisGoals<CR>', desc = 'Cornelis: Show all goals' },
      { '<C-c><C-x><C-r>', '<Cmd>CornelisRestart<CR>', desc = 'Cornelis: Kill and restart agda process' },
      { '<C-c><C-x><C-a>', '<Cmd>CornelisAbort<CR>', desc = 'Cornelis: Abort running command' },
      { '<C-c><C-s>', '<Cmd>CornelisSolve<CR>', desc = 'Cornelis: Solve constraints' },
      { '<M-.>', '<Cmd>CornelisGoToDefinition<CR>', desc = 'Cornelis: Jump to definition of name at cursor' },
      { '<C-c><C-b>', '<Cmd>CornelisPrevGoal<CR>', desc = 'Cornelis: Jump to previous goal' },
      { '<C-c><C-f>', '<Cmd>CornelisNextGoal<CR>', desc = 'Cornelis: Jump to next goal' },
      { '<C-c>]', '<Cmd>CornelisCloseInfoWindows<CR>', desc = 'Cornelis: Close all info windows' },

      { '<C-c><C-Space>', '<Cmd>CornelisGive<CR>', desc = 'Cornelis: Fill goal with hole contents' },
      { '<C-c><C-r>', '<Cmd>CornelisRefine<CR>', desc = 'Cornelis: Refine goal' },
      { '<C-c><C-m>', '<Cmd>CornelisElaborate<CR>', desc = 'Cornelis: Fill goal with normalized hole contents' },
      { '<C-c><C-a>', '<Cmd>CornelisAuto<CR>', desc = 'Cornelis: Automatic proof search' },
      { '<C-c><C-c>', '<Cmd>CornelisMakeCase<CR>', desc = 'Cornelis: Case split' },
      { '<C-c><C-,>', '<Cmd>CornelisTypeContext<CR>', desc = 'Cornelis: Show goal type and context' },
      { '<C-c><C-d>', '<Cmd>CornelisTypeInfer<CR>', desc = 'Cornelis: Show inferred type of hole contents' },
      { '<C-c><C-.>', '<Cmd>CornelisTypeContextInfer<CR>', desc = 'Cornelis: Show type, context & inferred type' },
      { '<C-c><C-n>', '<Cmd>CornelisNormalize<CR>', desc = 'Cornelis: Compute normal of hole contents' },
      { '<C-c><C-w>', '<Cmd>CornelisWhyInScope<CR>', desc = 'Cornelis: Show why given name is in scope' },
      { '<C-c><C-h>', '<Cmd>CornelisHelperFunc<CR>', desc = 'Cornelis: Copy inferred type to register' },
    },
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',

      -- optional dependencies:

      -- a completion engine
      --    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

      -- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
      -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
      -- 'andrewradev/switch.vim',        -- for switch support
      -- 'tomtom/tcomment_vim',           -- for commenting
    },

    ---@type lean.Config
    opts = { -- see below for full configuration options
      mappings = true,
    }
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    ft = { "js", "ts", "javascriptreact", "typescriptreact", "vue", "astro" },
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "neovim/nvim-lspconfig", -- optional
    },
    opts = {} -- your configuration
  },
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local metals_config = require("metals").bare_config()
      metals_config.settings = {
        useGlobalExecutable = true,
        showImplicitArguments = false,
        showImplicitConversionsAndClasses = false,
        showInferredType = true,
        autoImportBuild = "initial",
        serverProperties = {
          "-Xmx2G",
          "-Dmetals.enable-best-effort=true",
        },
        inlayHints = {
          hintsInPatternMatch = { enable = true },
          implicitArguments = { enable = false },
          implicitConversions = { enable = false },
          inferredTypes = { enable = true },
          typeParameters = { enable = false },
        },
      }
      metals_config.init_options.statusBarProvider = "off"
      metals_config.on_attach = function()
        require("metals").setup_dap()
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
      })
    end,
  },
  {
    'moonbit-community/moonbit.nvim',
    ft = { 'moonbit' },
    deps = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      mooncakes = {
        virtual_text = true,
        use_local = true,
      },
      treesitter = {
        enabled = true,
        auto_install = true
      },
      lsp = {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      }
    },
  },
  {
    'wojciech-kulik/xcodebuild.nvim',
    lazy = true,
    event = 'BufEnter *.swift',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
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
        if not current_dir then return false end
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
      -- vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })

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
}
