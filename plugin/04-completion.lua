vim.pack.add {
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range 'v1.*',
  },
  'https://github.com/rafamadriz/friendly-snippets',
}

local sources = {
  default = { 'lsp', 'path', 'snippets', 'buffer' },
}
if vim.tbl_contains(vim.g.lazylangs.langs, 'lua') then
  sources = {
    -- add lazydev to your completion providers
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  }
end

require('blink-cmp').setup {
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  sources = sources,
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
}
