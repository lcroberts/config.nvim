vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}

require('conform').setup {
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
    lua = { 'stylua' },
  },
}
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set('n', '<leader>fm', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })
