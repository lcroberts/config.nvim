---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'phpantom_lsp',
    server_configuration = {},
  },
  mason_packages = {
    'phpantom_lsp',
    'php-debug-adapter',
  },
  setup = function()
    local dap = require 'dap'
    local paths = require 'lazylangs.helpers.paths'
    dap.adapters.php = {
      type = 'executable',
      command = paths.mason_bin_path 'php-debug-adapter',
      args = {},
    }
    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
      },
    }
  end,
}
