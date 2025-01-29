local vim = vim

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            follow = true,
          },
        },
        defaults = {
          mappings = {
            i = {
              ['<C-n>'] = require('telescope.actions').move_selection_next,
              ['<C-p>'] = require('telescope.actions').move_selection_previous,
            },
          },
          vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          prompt_prefix = '   ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          path_display = { 'truncate' },
          color_devicons = true,
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path
      local function find_git_root()
        -- Use the current buffer's path as the starting point for the git search
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        -- If the buffer is not associated with a file, return nil
        if current_file == '' then
          current_dir = cwd
        else
          -- Extract the directory from the current file's path
          current_dir = vim.fn.fnamemodify(current_file, ':h')
        end

        -- Find the Git root directory from the current file's path
        local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
        if vim.v.shell_error ~= 0 then
          print 'Not a git repository. Searching on current working directory'
          return cwd
        end
        return git_root
      end

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          require('telescope.builtin').live_grep {
            search_dirs = { git_root },
          }
        end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

      -- Custom live_grep function to search in git root
      local function enter_config()
        local config_dir = vim.fn.stdpath 'config'
        vim.cmd([[cd ]] .. config_dir)
        require('telescope.builtin').find_files { cwd = config_dir }
      end

      vim.api.nvim_create_user_command('EnterConfig', enter_config, {})

      local function telescope_live_grep_open_files()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end

      vim.keymap.set({ 'n' }, '<leader>sb', require('telescope.builtin').buffers, { desc = '[s]earch existing [b]uffers' })
      vim.keymap.set({ 'n' }, '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
      vim.keymap.set({ 'n' }, '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp page' })
      vim.keymap.set({ 'n' }, '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
      -- vim.keymap.set({ 'n' }, '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
      -- vim.keymap.set({ 'n' }, '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
      vim.keymap.set({ 'n' }, '<leader>s/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[f]uzzily search [/] in current buffer' })

      -- Theme search
      vim.keymap.set({ 'n' }, '<leader>st', require('telescope.builtin').colorscheme, { desc = '[s]earch [t]hemes' })
      require('local_plugins.multigrep').setup()
      require('local_plugins.directory_picker').setup()
    end,
  },
}
