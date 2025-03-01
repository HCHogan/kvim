return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }

      local lldb = {
        name = "Launch lldb",
        type = "lldb",      -- matches the adapter
        request = "launch", -- could also attach to a currently running process
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      }

      dap.configurations = {
        rust = {
          lldb
        },
        cpp = {
          lldb
        },
      }
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    config = function()
      require("dapui").setup()
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
      'nvim-neotest/nvim-nio',
    },
  }
}
