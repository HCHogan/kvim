local icons = require('core.icons').icons

require('neo-tree').setup {
  default_component_configs = {
    indent = {
      padding = 0,
      expander_collapsed = icons.FoldClosed,
      expander_expanded = icons.FoldOpened,
    },
    icon = {
      folder_closed = icons.FolderClosed,
      folder_open = icons.FolderOpen,
      folder_empty = icons.FolderEmpty,
      folder_empty_open = icons.FolderEmpty,
      default = icons.DefaultFile,
    },
    modified = { symbol = icons.FileModified },
    git_status = {
      symbols = {
        added = icons.GitAdd,
        deleted = icons.GitDelete,
        modified = icons.GitChange,
        renamed = icons.GitRenamed,
        untracked = icons.GitUntracked,
        ignored = icons.GitIgnored,
        unstaged = icons.GitUnstaged,
        staged = icons.GitStaged,
        conflict = icons.GitConflict,
      },
    },
  },

  filesystem = {
    window = {
      width = 30,
      mappings = {
        --['<S-CR>'] = 'system_open',
        -- ['[b'] = 'prev_source',
        -- [']b'] = 'next_source',
        -- O = 'system_open',
        -- Y = 'copy_selector',
        -- h = 'parent_or_close',
        -- l = 'child_or_open',
        ['<leader>e'] = 'close_window',
        ['<Space>'] = false,
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<C-J>'] = 'move_cursor_down',
        ['<C-K>'] = 'move_cursor_up',
      },
    },
  },
}

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'NeoTree toggle' },
  },
  opts = {},
}
