vim.loader.enable()
require 'options'
require 'keymaps'

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
    if name == 'telescope-fzf-native.nvim' then
      if not ev.data.active then
        vim.cmd.packadd 'telescope-fzf-native.nvim'
      end
      vim.fn.system 'make'
    end
  end,
})

vim.pack.clean = function()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print 'No unused plugins.'
    return
  end

  local choice = vim.fn.confirm('Remove unused plugins?', '&Yes\n&No', 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

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

-- Create autocmds
require 'autocmd'

-- vim: ts=2 sts=2 sw=2 et
