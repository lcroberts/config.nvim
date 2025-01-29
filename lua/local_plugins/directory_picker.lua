local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values
local M = {}

M.directory_search = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end
      local pieces = vim.split(prompt, '  ')
      args = { 'fd' }
      if pieces[1] then
        table.insert(args, '-g') -- Glob instead of regex
        table.insert(args, '*' .. pieces[1] .. '*')
        -- Directories only
        table.insert(args, '-t')
        table.insert(args, 'd')
        -- Follow symlinks
        table.insert(args, 'L')
      end

      if pieces[2] then
        table.insert(args, '-E') -- Exclude directory
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten { args, { '--color', 'never', '.' } }
    end,
    entry_maker = make_entry.gen_from_string(opts),
    cws = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Directory Search',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

M.setup = function()
  vim.keymap.set('n', '<leader>sd', M.directory_search, { desc = '[S]earch [D]irectory' })
end

return M
