require 'custom.options'
require 'custom.keymaps'
require 'custom.autocommands'

-- [[Install 'rocks.nvim' plugin manager]]
-- luarocks --lua-version=5.1 --tree <rocks_path> --server='https://nvim-neorocks.github.io/rocks-binaries/' install rocks.nvim
local rocks_config = {
  rocks_path = vim.fn.stdpath 'data' .. '/rocks',
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?.lua'),
  vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?', 'init.lua'),
}
package.path = package.path .. ';' .. table.concat(luarocks_path, ';')

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.so'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.so'),

  -- add these on Windows
  vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.dll'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.dll'),
}
package.cpath = package.cpath .. ';' .. table.concat(luarocks_cpath, ';')

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'luarocks', 'rocks-5.1', 'rocks.nvim', '*'))

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  require 'custom.cmp',
  require 'custom.finder',
  require 'custom.lint',
  require 'custom.lsp',
  require 'custom.treesitter',
  require 'custom.ui',

  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
