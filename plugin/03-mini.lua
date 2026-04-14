vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}

require('mini.ai').setup { n_lines = 500 }
require('mini.icons').setup({})
require('mini.indentscope').setup {
  symbol = '│',
  options = {
    try_as_border = true,
  },
}
require('mini.pairs').setup {}
require('mini.statusline').setup {}
require('mini.splitjoin').setup {
  mappings = { toggle = 'g,' },
}
require('mini.surround').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'dashboard',
    'snacks-dashboard',
    'lazy',
    'mason',
    'notify',
    'toggleterm',
    'trouble',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
