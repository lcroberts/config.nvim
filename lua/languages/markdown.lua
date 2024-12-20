---@module 'LazyLanguages'
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
          opts = {
            sources = {
              -- add markdown to your completion providers
              default = { 'markdown' },
              providers = {
                markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink' },
              },
            },
            opts_extend = { 'sources.default', 'sources.providers' },
          },
        }
      }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        enabled = true,
        preset = 'obsidian',
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
        },
        attachments = {
          img_folder = '_resources',
        },
        workspaces = {
          {
            name = 'school',
            path = '~/MarkdownNotes/School Notes/',
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
}
