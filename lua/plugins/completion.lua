return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {},
    config = function(_, opts)
      require('luasnip').setup(opts)

      -- Prevent cursed af snippet behavior
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*',
        callback = function()
          if
            ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
          then
            require('luasnip').unlink_current()
          end
        end,
      })
    end,
  },
  {
    'saghen/blink.cmp',
    version = 'v0.*',
    -- !Important! Make sure you're using the latest release of LuaSnip
    -- `main` does not work at the moment
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
      sources = {
        default = { 'lsp', 'path', 'luasnip', 'buffer' },
      },
      completion = {
        menu = {
          draw = {
            padding = 0,
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  return ' ' .. ctx.kind_icon .. ' '
                end,
              },
            },
          },
        },
      },
    },
  },
}
