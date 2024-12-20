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
    'saghen/blink.cmp',
    {
      'mfussenegger/nvim-lint',
      config = function()
        -- Disable default enabled linters
        local lint = require('lint')
        lint.linters_by_ft.clojure = nil
        lint.linters_by_ft.dockerfile = nil
        lint.linters_by_ft.inko = nil
        lint.linters_by_ft.janet = nil
        lint.linters_by_ft.json = nil
        lint.linters_by_ft.markdown = nil
        lint.linters_by_ft.rst = nil
        lint.linters_by_ft.ruby = nil
        lint.linters_by_ft.terraform = nil
        lint.linters_by_ft.text = nil
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
          callback = function()
            require('lint').try_lint()
          end,
        })
      end,
    },
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
