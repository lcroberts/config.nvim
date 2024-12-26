require 'options'
require 'keymaps'

if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      -- event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      event = 'VeryLazy',
    },
  }
end

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local langs = { 'lua', 'bash', 'markdown' }
local success, file_langs = pcall(require, 'languages')
if success then
  for _, language in ipairs(file_langs) do
    if not vim.list_contains(langs, language) then
      table.insert(langs, language)
    end
  end
end
vim.g.lazylangs = {
  override_path = 'languages', -- '.' separated path relative to the lua directory
  formatting_plugin = 'conform',
  completion_plugin = 'blink.cmp',
  linting_plugin = 'nvim-lint',
  debugging_plugin = 'nvim-dap',
  langs = langs, -- string[] of language names
}

require('lazy').setup {
  dev = {
    path = '~/Projects/nvim-plugins/',
    fallback = true,
  },
  install = {
    colorscheme = { 'catppuccin-mocha' },
  },
  spec = {
    { import = 'plugins' },
  },
}

-- Create autocmds
require 'autocmd'

-- vim: ts=2 sts=2 sw=2 et
