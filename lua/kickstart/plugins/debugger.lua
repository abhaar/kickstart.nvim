return {
  {
    'mfussenegger/nvim-dap',

    dependencies = {
      'rcarriga/nvim-dap-ui',
      'leoluz/nvim-dap-go',
      'nvim-neotest/nvim-nio',
    },

    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()

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

      vim.keymap.set('n', '<leader>dt', ':DapUiToggle<CR>', { desc = 'Toggle Dap UI' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<leader>dr', ":lua require('dapui').open({reset=true})<CR>", { desc = 'Restart' })

      vim.fn.sign_define('DapBreakpoint', { text = '⏺', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    end,
  },
  {
    -- 'mfussenegger/nvim-dap-python',
    -- ft = 'python',
    -- dependencies = { 'mfussenegger/nvim-dap' },
    -- config = function()
    --   local dap, dapui = require 'dap', require 'dapui'
    --
    --   require('dapui').setup()
    --
    --   dap.listeners.before.attach.dapui_config = function()
    --     dapui.open()
    --   end
    --
    --   dap.listeners.before.launch.dapui_config = function()
    --     dapui.open()
    --   end
    --
    --   dap.listeners.before.event_terminated.dapui_config = function()
    --     dapui.close()
    --   end
    --
    --   dap.listeners.before.event_exited.dapui_config = function()
    --     dapui.close()
    --   end
    --
    --   local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
    --   require('dap-python').setup(path)
    -- end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
  },
}
