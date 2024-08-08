local icons = require('core.icons').icons

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  opts = function()
    local git_available = vim.fn.executable "git" == 1
    local sources = {
      { source = "filesystem",  display_name = icons.FolderClosed .. " File" },
      { source = "buffers",     display_name = icons.DefaultFile .. " Bufs" },
      { source = "diagnostics", display_name = icons.Diagnostic .. " Diagnostic" },
    }
    if git_available then
      table.insert(sources, 3, { source = "git_status", display_name = icons.Git .. " Git" })
    end

    local opts = {
      enable_git_status = git_available,
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      sources = { "filesystem", "buffers", git_available and "git_status" or nil },
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = sources,
      },
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
      window = {
        width = 30,
        mappings = {
          ['[b'] = 'prev_source',
          [']b'] = 'next_source',
          ['<leader>e'] = 'close_window',
          ['<Space>'] = false,
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ['<C-J>'] = 'move_cursor_down',
          ['<C-K>'] = 'move_cursor_up',
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = { hide_gitignored = git_available },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
            vim.opt_local.foldcolumn = "0"
          end,
        },
      },

    }
    return opts
  end,
}
