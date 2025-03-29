---@diagnostic disable: missing-fields
return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = 'v1.*',
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
