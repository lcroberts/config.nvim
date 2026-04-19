Terminal = {
  buf = -1,
  win = -1,
}

function Terminal:new(o)
  local object = o or {}
  setmetatable(object, self)
  self.__index = self
  return object
end

function Terminal:open()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(self.buf) then
    buf = self.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    self.buf = buf
  end
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  self.win = win
end

function Terminal:toggle()
  if not vim.api.nvim_win_is_valid(self.win) then
    self:open()
    if vim.bo[self.buf].buftype ~= 'terminal' then
      vim.cmd.term()
    end
    vim.cmd 'startinsert'
  else
    vim.api.nvim_win_hide(self.win)
  end
end

local terminals = { 't', '1', '2', '3' }

vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
for _, value in ipairs(terminals) do
  local term = Terminal:new()
  vim.keymap.set({ 'n', 't' }, '<leader>t' .. value, function()
    term:toggle()
  end, { desc = 'Toggle term ' .. value })
end
