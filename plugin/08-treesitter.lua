vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

local parsers = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart
  return line .. ' 󰁂 ' .. line_count .. ' lines'
end
vim.wo.foldenable = true
vim.wo.foldlevel = 99
vim.wo.foldtext = 'v:lua.custom_fold_text()'
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldmethod = 'expr'
vim.opt.fillchars:append { fold = ' ' }
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
