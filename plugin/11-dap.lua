vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
}

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.keymap.set({ 'n' }, '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Toggle Breakpoint' })
vim.keymap.set({ 'n' }, '<leader>dc', '<cmd> DapContinue <CR>', { desc = 'Start or continue debugger' })
vim.keymap.set({ 'n' }, '<leader>dsu', function()
  local widgets = require 'dap.ui.widgets'
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = 'Open debugging sidebar' })

require('nvim-dap-virtual-text').setup {
  virt_text_pos = 'eol',
}

local dap = require 'dap'
local dapui = require 'dapui'
dapui.setup(opts)
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
