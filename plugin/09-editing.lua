vim.pack.add {
  'https://github.com/HiPhish/rainbow-delimiters.nvim',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/mbbill/undotree',
  {
    src = 'https://github.com/lukas-reineke/indent-blankline.nvim',
    name = 'ibl',
  },
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/jmbuhr/otter.nvim',
}

vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = 'Undotree Toggle' })
require('ibl').setup {
  indent = {
    char = '│',
    tab_char = '│',
  },
  exclude = {
    filetypes = {
      'dashboard',
      'snacks-dashboard',
    },
  },
}

require('todo-comments').setup {
  signs = true,
}
vim.keymap.set('n', '<leader>tc', '<cmd>TodoQuickFix<cr>', { desc = 'Todo Quick Fix' })

require('trouble').setup {}

vim.keymap.set('n', '<leader>tx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>tX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>tL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>tQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

require('otter').setup {}
vim.keymap.set('n', '<leader>to', function()
  require('otter').activate()
end, { desc = 'Otter Activate' })
