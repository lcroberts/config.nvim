-- Mapping mode: n (normal), x (visual), i (insert), c (command)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n' }, '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })
vim.keymap.set({ 'n' }, '<leader>p', [["+p]], { desc = 'Paste from clipboard' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set('x', '<leader>P', [["_d"+P]], { desc = 'Paste from clipboard without yanking' })

vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>zz', { desc = 'Next in quickfix list' })
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>zz', { desc = 'Prev in quickfix list' })

vim.keymap.set({ 'n', 't' }, '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'window right' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'window up' })

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>', { silent = true })
-- Clear highlights
vim.keymap.set({ 'n' }, '<Esc>', '<cmd> noh<cr>', { desc = 'Clear highlights' })
-- Remap for dealing with word wrap
vim.keymap.set({ 'n' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n' }, '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set({ 'n' }, '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set({ 'n' }, 'n', 'nzzzv', { silent = true })
vim.keymap.set({ 'n' }, 'N', 'Nzzzv', { silent = true })

vim.keymap.set({ 'x' }, 'A', ':s/$/', { desc = 'Append to lines' })

-- Move visual selection around
vim.keymap.set({ 'x' }, 'H', '<gv', { desc = 'Move selection left' })
vim.keymap.set({ 'x' }, 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set({ 'x' }, 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set({ 'x' }, 'L', '>gv', { desc = 'Move selection right' })

-- Navigate in insert mode
vim.keymap.set({ 'i' }, '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set({ 'i' }, '<C-l>', '<Right>', { desc = 'Move right' })
vim.keymap.set({ 'i' }, '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set({ 'i' }, '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set({ 'i' }, '<C-b>', '<Esc>_i', { desc = 'Beginning of line' })
vim.keymap.set({ 'i' }, '<C-e>', '<End>', { desc = 'End of line' })
vim.keymap.set({ 'i' }, '<A-;>', '<End>;', { desc = 'Append Semicolon' })
vim.keymap.set({ 'i' }, '<A-,>', '<End>,', { desc = 'Append Comma' })

vim.keymap.set({ 'c' }, '<M-/>', [[\/]], { desc = 'Insert escaped slash' })

-- Example terminal open with command
-- local job_id = 0
-- vim.keymap.set('n', '<space>open', function()
--   vim.cmd.vnew()
--   vim.cmd.term()
--   vim.cmd.wincmd 'J'
--   vim.api.nvim_win_set_height(0, 15)
--   job_id = vim.bo.channel
-- end)
--
-- vim.keymap.set('n', '<space>example', function()
--   vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
-- end)
