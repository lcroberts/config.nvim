return {
  {
    'folke/snacks.nvim',
    opts = function()
      -- Toggle the profiler
      Snacks.toggle.profiler():map '<leader>pp'
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map '<leader>ph'
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      words = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      notifier = {
        enabled = true,
        style = 'compact',
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { action = ':Telescope find_files', desc = ' Search files', icon = ' ', key = 's' },
            { action = require('local_plugins.multigrep').live_multigrep, desc = ' Grep text', icon = ' ', key = 'g' },
            { action = ':Telescope oldfiles', desc = ' Recent files', icon = ' ', key = 'r' },
            { action = ':ene | startinsert', desc = ' New file', icon = ' ', key = 'n' },
            { action = ':Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
            { action = ':Mason', desc = ' Mason', icon = ' ', key = 'm' },
            { action = ':EnterConfig', desc = ' Config', icon = ' ', key = 'c' },
            { action = ':qa', desc = ' Quit', icon = ' ', key = 'q' },
          },
          header = [[
     ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗     ████████╗██╗███╗   ███╗███████╗██╗
    ██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝     ╚══██╔══╝██║████╗ ████║██╔════╝██║
    ██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗       ██║   ██║██╔████╔██║█████╗  ██║
    ██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║       ██║   ██║██║╚██╔╝██║██╔══╝  ╚═╝
    ╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝       ██║   ██║██║ ╚═╝ ██║███████╗██╗
     ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝]],
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
    keys = {
      {
        '<leader>nd',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Notification Dismiss',
      },
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
        end,
      })
    end,
  },
}
