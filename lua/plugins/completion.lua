---@diagnostic disable: missing-fields
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
      -- vim.api.nvim_create_autocmd('ModeChanged', {
      --   pattern = '*',
      --   callback = function()
      --     if
      --       ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      --       and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      --       and not require('luasnip').session.jump_active
      --     then
      --       require('luasnip').unlink_current()
      --     end
      --   end,
      -- })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip' },

    version = 'v0.*',
    opts_extend = { 'sources' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

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

      signature = {
        enabled = true,
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          draw = {
            padding = { 0, 1 },
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
