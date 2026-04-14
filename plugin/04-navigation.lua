vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/stevearc/oil.nvim',
  {
    src = 'https://github.com/ThePrimeagen/harpoon',
    version = 'harpoon2',
  },
}

local harpoon = require 'harpoon'

harpoon:setup {
  settings = {
    save_on_toggle = true,
    save_on_ui_close = true,
  },
}
vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<leader>hl', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end)
vim.keymap.set('n', '<leader>5', function()
  harpoon:list():select(5)
end)

---@module 'oil'
---@type oil.SetupOpts
require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<BS>'] = 'actions.parent',
    ['.'] = 'actions.cd',
  },
}
vim.keymap.set('n', '<leader>fv', '<cmd>Oil<cr>', { desc = 'File View' })
