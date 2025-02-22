return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>fm',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Enable "format_on_save lsp_fallback" for languages
      local enable_filetypes = { go = true, rust = true, lua = true }
      if enable_filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 500,
          lsp_fallback = enable_filetypes[vim.bo[bufnr].filetype],
        }
      end
    end,
    formatters_by_ft = {
      -- lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      -- You can customize some of the format options for the filetype (:help conform.format)
      -- rust = { 'rustfmt', lsp_format = 'fallback' },
      -- Conform will run the first available formatter
      -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
