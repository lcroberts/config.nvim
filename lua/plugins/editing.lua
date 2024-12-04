return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
  },

  'tpope/vim-eunuch',
  'tpope/vim-repeat',

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

  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    opts = {
      delay = 200,
      large_file_cutoff = 5000,
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    keys = {
      {
        ']]',
        function()
          require('illuminate').goto_next_reference(true)
        end,
        desc = 'Next Reference',
      },
      {
        '[[',
        function()
          require('illuminate').goto_prev_reference(true)
        end,
        desc = 'Previous Reference',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    opts = {
      signs = true,
    },
    keys = {
      { '<leader>tc', '<cmd>TodoQuickFix<cr>', desc = 'Todo Quick Fix' },
    },
  },

  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>tX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>ts',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>tl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>tL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>tQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
