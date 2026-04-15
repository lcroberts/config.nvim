local helpers = require 'helpers'

local lazylangs_path = helpers.plugin_path .. 'lazylangs.nvim'
if vim.fn.filereadable(lazylangs_path) then
  vim.opt.runtimepath:append(lazylangs_path)
else
  vim.pack.add {
    'https://github.com/lcroberts/lazylangs.nvim',
  }
end

vim.pack.add {
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/chrisgrieser/nvim-lsp-endhints',
}

vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    require('lsp-endhints').setup {
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
    }
  end,
})

-- Disable default enabled linters
local lint = require 'lint'
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

require('lazylangs').setup {
  mason = {
    automatic_install = true,
    automatic_update = false,
  },
}
