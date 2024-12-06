return {
  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
  },

  {
    'lcroberts/persistent-colorscheme.nvim',
    dev = true,
    lazy = false,
    priority = 1000,
    dependencies = {
      'RRethy/nvim-base16', -- Lots of baked-in themes and support to add more
      {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
          custom_highlights = function(C)
            return {
              CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
              CmpItemKindKeyword = { fg = C.base, bg = C.red },
              CmpItemKindText = { fg = C.base, bg = C.teal },
              CmpItemKindMethod = { fg = C.base, bg = C.blue },
              CmpItemKindConstructor = { fg = C.base, bg = C.blue },
              CmpItemKindFunction = { fg = C.base, bg = C.blue },
              CmpItemKindFolder = { fg = C.base, bg = C.blue },
              CmpItemKindModule = { fg = C.base, bg = C.blue },
              CmpItemKindConstant = { fg = C.base, bg = C.peach },
              CmpItemKindField = { fg = C.base, bg = C.green },
              CmpItemKindProperty = { fg = C.base, bg = C.green },
              CmpItemKindEnum = { fg = C.base, bg = C.green },
              CmpItemKindUnit = { fg = C.base, bg = C.green },
              CmpItemKindClass = { fg = C.base, bg = C.yellow },
              CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
              CmpItemKindFile = { fg = C.base, bg = C.blue },
              CmpItemKindInterface = { fg = C.base, bg = C.yellow },
              CmpItemKindColor = { fg = C.base, bg = C.red },
              CmpItemKindReference = { fg = C.base, bg = C.red },
              CmpItemKindEnumMember = { fg = C.base, bg = C.red },
              CmpItemKindStruct = { fg = C.base, bg = C.blue },
              CmpItemKindValue = { fg = C.base, bg = C.peach },
              CmpItemKindEvent = { fg = C.base, bg = C.blue },
              CmpItemKindOperator = { fg = C.base, bg = C.blue },
              CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
              CmpItemKindCopilot = { fg = C.base, bg = C.teal },
            }
          end,
        },
      },
    },
    opts = {
      colorscheme = 'catppuccin',
      transparent = true,
      transparency_options = {
        always_transparent = {
          'Folded',
          'LspInlayHint',
        },
      },
    },
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug and [D]iagnostics' },
        { '<leader>g', group = '[G]it and [G]oto' },
        { '<leader>h', group = '[H]arpoon and Git [H]unk' },
        { '<leader>r', group = '[R]ename and [R]estart' },
        { '<leader>f', group = '[F]ind and [F]ormat' },
        { '<leader>t', group = '[T]oggle and [T]rouble' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>1', hidden = true },
        { '<leader>2', hidden = true },
        { '<leader>3', hidden = true },
        { '<leader>4', hidden = true },
        { '<leader>5', hidden = true },
        {
          mode = { 'v' },
          { '<leader>', group = 'VISUAL <leader>' },
          { '<leader>h', group = 'Git [H]unk' },
        },
      },
    },
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '󰍵' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      }, -- See `:help gitsigns.txt`
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next Hunk' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Prev Hunk' })

        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage Hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset Hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Blame Line' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Toggle Deleted' })
      end,
    },
    dependencies = {
      'lcroberts/persistent-colorscheme.nvim',
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      require('persistent-colorscheme').make_prefix_transparent 'GitGutter'
    end,
  },
}
