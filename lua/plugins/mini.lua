return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.comment').setup()
    require('mini.indentscope').setup {
      symbol = '│',
      options = {
        try_as_border = true,
      },
    }
    require('mini.jump2d').setup()
    require('mini.splitjoin').setup {
      mappings = { toggle = 'g,' },
    }
    require('mini.pairs').setup {
      modes = { insert = true, command = false, terminal = false },
    }
    require('mini.surround').setup()

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'dashboard',
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
  end,
}
