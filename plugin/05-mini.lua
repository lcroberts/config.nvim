vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}

require('mini.ai').setup { n_lines = 500 }
require('mini.icons').setup {}
require('mini.pairs').setup {}
require('mini.statusline').setup {}
require('mini.splitjoin').setup {
  mappings = { toggle = 'g,' },
}
require('mini.surround').setup()
