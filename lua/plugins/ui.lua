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
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
    opts = {},
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      -- IDK why I have to do the text like this but it works
      local logo = [[
 ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗     ████████╗██╗███╗   ███╗███████╗██╗
██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝     ╚══██╔══╝██║████╗ ████║██╔════╝██║
██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗       ██║   ██║██╔████╔██║█████╗  ██║
██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║       ██║   ██║██║╚██╔╝██║██╔══╝  ╚═╝
╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝       ██║   ██║██║ ╚═╝ ██║███████╗██╗
 ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝
        ]]
      logo = string.rep('\n', 4) .. logo .. '\n\n'
      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
          center = {
            { action = 'Telescope find_files', desc = ' Search files', icon = ' ', key = 's' },
            { action = 'Telescope live_grep', desc = ' Grep text', icon = ' ', key = 'g' },
            { action = 'Telescope oldfiles', desc = ' Recent files', icon = ' ', key = 'r' },
            { action = 'ene | startinsert', desc = ' New file', icon = ' ', key = 'n' },
            { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
            { action = 'Mason', desc = ' Mason', icon = ' ', key = 'm' },
            { action = 'EnterConfig', desc = ' Config', icon = ' ', key = 'c' },
            { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
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
        { '<leader>r', group = '[R]ename and [R]ust' },
        { '<leader>f', group = '[F]ind and [F]ormat' },
        { '<leader>t', group = '[T]oggle and [T]rouble' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>b', group = '[B]lock' },
        { '<leader>n', group = '[N]eorg' },
        { '<leader>1', hidden = true },
        { '<leader>2', hidden = true },
        { '<leader>3', hidden = true },
        { '<leader>4', hidden = true },
        { '<leader>5', hidden = true },
        {
          mode = { 'v' },
          { '<leader>', group = 'VISUAL <leader>' },
          { '<leader>b', group = '[B]lock' },
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
      on_attach = function()
        vim.keymap.set({ 'n' }, '<leader>hs', package.loaded.gitsigns.stage_hunk, { desc = 'git stage hunk' })
        vim.keymap.set({ 'n' }, '<leader>hr', package.loaded.gitsigns.reset_hunk, { desc = 'git reset hunk' })
        vim.keymap.set({ 'n' }, '<leader>hS', package.loaded.gitsigns.stage_buffer, { desc = 'git Stage buffer' })
        vim.keymap.set({ 'n' }, '<leader>hu', package.loaded.gitsigns.undo_stage_hunk, { desc = 'undo stage hunk' })
        vim.keymap.set({ 'n' }, '<leader>hR', package.loaded.gitsigns.reset_buffer, { desc = 'git Reset buffer' })
        vim.keymap.set({ 'n' }, '<leader>hp', package.loaded.gitsigns.preview_hunk, { desc = 'preview git hunk' })
        vim.keymap.set({ 'n' }, '<leader>hd', package.loaded.gitsigns.diffthis, { desc = 'git diff against index' })

        vim.keymap.set({ 'n' }, '<leader>hb', function()
          package.loaded.gitsigns.blame_line { full = false }
        end, { desc = 'git blame line' })

        vim.keymap.set({ 'n' }, '<leader>hD', function()
          package.loaded.gitsigns.diffthis '~'
        end, { desc = 'git diff against last commit' })

        vim.keymap.set({ 'n' }, '<leader>gd', package.loaded.gitsigns.toggle_deleted, { desc = 'toggle [g]it show [d]eleted' })
        vim.keymap.set({ 'n' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            package.loaded.gitsigns.next_hunk()
          end)
          return '<Ignore>'
        end, { desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n' }, '<leader>hs', function()
          package.loaded.gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })

        vim.keymap.set({ 'n' }, '<leader>hr', function()
          package.loaded.gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
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
