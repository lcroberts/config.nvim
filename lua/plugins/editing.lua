return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
  },

  'tpope/vim-eunuch',
  'tpope/vim-repeat',

  {
    'tpope/vim-rhubarb',
    dependencies = {
      {
        'tpope/vim-fugitive',
        keys = {
          { '<leader>gs', vim.cmd.Git, desc = 'Open git' },
        },
      },
    },
  },

  {
    'mbbill/undotree',
    event = 'VeryLazy',
    keys = {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = 'Undotree Toggle' },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      exclude = {
        filetypes = {
          'dashboard',
        },
      },
    },
  },
}
