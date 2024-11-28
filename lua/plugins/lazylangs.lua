return {
  'lcroberts/LazyLanguages.nvim',
  url = 'git@github.com:lcroberts/LazyLanguages.nvim', -- Keep while repo is private
  dev = true,
  event = 'VeryLazy',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'stevearc/conform.nvim',
    'mfussenegger/nvim-dap',
    {
      'chrisgrieser/nvim-lsp-endhints',
      event = 'LspAttach',
      opts = {
        icons = {
          type = '=> ',
          parameter = '<- ',
          offspec = '=> ', -- hint kind not defined in official LSP spec
          unknown = '=> ', -- hint kind is nil
        },
        label = {
          padding = 0,
          marginLeft = 0,
          sameKindSeparator = ', ',
        },
        autoEnableHints = false,
      },
    },
  },
  ---@module 'LazyLanguages'
  ---@type ll.Config
  opts = {
    mason = {
      automatic_install = true,
      automatic_update = true,
    },
  },
  import = 'LazyLanguages.plugins',
}
