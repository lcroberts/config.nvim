vim.pack.add {
  'https://github.com/folke/snacks.nvim',
}

require('snacks').setup {
  bigfile = { enabled = true },
  words = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  indent = { enabled = true },
  notifier = {
    enabled = true,
    style = 'compact',
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    -- Setup some globals for debugging (lazy-loaded)
    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    _G.bt = function()
      Snacks.debug.backtrace()
    end
  end,
})

vim.keymap.set('n', '<leader>nd', function()
  Snacks.notifier.hide()
end, { desc = 'Notification Dismiss' })
vim.keymap.set('n', '<leader>nh', function()
  Snacks.notifier.show_history()
end, { desc = 'Notification History' })
vim.keymap.set({ 'n', 't' }, ']]', function()
  Snacks.words.jump(vim.v.count1)
end, { desc = 'Next Reference' })
vim.keymap.set({ 'n', 't' }, '[[', function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = 'Prev Reference' })
vim.keymap.set('n', '<leader>gf', function()
  Snacks.lazygit.log_file()
end, { desc = 'Lazygit Current File History' })
vim.keymap.set('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gl', function()
  Snacks.lazygit.log()
end, { desc = 'Lazygit Log (cwd)' })
