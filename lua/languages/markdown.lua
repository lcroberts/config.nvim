---@module 'lazylangs'
---@type ll.Language
return {
  plugins = {
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = 'markdown',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
        {
          'saghen/blink.cmp',
          opts_extend = { 'sources' },
          opts = {
            sources = {
              -- add markdown to your completion providers
              default = { 'markdown' },
              providers = {
                markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink' },
              },
            },
          },
        },
      }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        enabled = true,
        preset = 'obsidian',
        checkbox = {
          checked = { scope_highlight = '@markup.strikethrough' },
          custom = {
            in_progress = { raw = '[~]', rendered = '󰥔', highlight = 'DiagnosticWarn' },
            important = { raw = '[!]', rendered = '', highlight = 'DiagnosticError' },
          },
        },
      },
    },
    {
      'epwalsh/obsidian.nvim',
      version = '*',
      ft = 'markdown',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      opts = {
        ui = {
          enable = false,
          checkboxes = {
            [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
            -- ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
            ['x'] = { char = '', hl_group = 'ObsidianDone' },
            -- ['!'] = { char = '', hl_group = 'ObsidianImportant' },
          },
        },
        attachments = {
          img_folder = '_resources',
        },
        disable_frontmatter = false,
        preferred_link_style = 'markdown',
        workspaces = {
          {
            name = 'Notes',
            path = '~/Notes/',
          },
          {
            name = 'no-vault',
            path = function()
              -- alternatively use the CWD:
              -- return assert(vim.fn.getcwd())
              return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
            end,
            overrides = {
              notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
              new_notes_location = 'current_dir',
              templates = {
                folder = vim.NIL,
              },
              disable_frontmatter = true,
            },
          },
        },
      },
    },
    {
      '3rd/image.nvim',
      event = 'VeryLazy',
      build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
      opts = {
        integrations = {
          markdown = {
            resolve_image_path = function(document_path, image_path, fallback)
              local working_dir = vim.fn.getcwd()
              -- Format image path for Obsidian notes
              if working_dir:find '~/Notes/' then
                return working_dir .. '/' .. image_path
              end
              require ''
              -- Fallback to the default behavior
              return fallback(document_path, image_path)
            end,
          },
        },
        backend = 'kitty',
        processor = 'magick_cli',
      },
    },
  },
  lsp = {
    name = 'markdown_oxide',
    server_configuration = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    },
  },
  mason_packages = {
    'markdown-oxide',
  },
  setup = function()
    vim.keymap.set('n', '<leader>sn', function()
      require('telescope.builtin').find_files { cwd = '~/Notes/' }
    end, { desc = 'Search Notes' })
  end,
}
