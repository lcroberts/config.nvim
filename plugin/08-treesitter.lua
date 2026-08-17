vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

local ts = require 'nvim-treesitter'

local parsers = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
ts.install(parsers)

-- Start treesitter for any filetype with an available parser, and offer to
-- install the parser when one exists upstream but is not installed yet.
local prompted = {} ---@type table<string, true> langs already asked about this session

local function start(buf, lang)
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.treesitter.start, buf, lang)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

--- Start treesitter in every loaded buffer using `lang`
local function start_all(lang)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.treesitter.language.get_lang(vim.bo[buf].filetype) == lang then
      start(buf, lang)
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then
      return
    end

    -- Parser installed, or shipped with nvim
    if vim.treesitter.language.add(lang) then
      start(args.buf, lang)
      return
    end

    -- Nothing to install: no upstream parser for this filetype, so stay quiet
    if prompted[lang] or not vim.list_contains(ts.get_available(), lang) then
      return
    end
    prompted[lang] = true

    vim.schedule(function()
      local confirmed = vim.fn.confirm('Install tree sitter parser for ' .. lang, '&Yes\n&No', 2)
      if confirmed == 1 then
        ts.install(lang):await(function(err, ok)
          vim.schedule(function()
            local loaded, load_err = vim.treesitter.language.add(lang)
            if err or not ok or not loaded then
              prompted[lang] = nil -- ask again next time so a failure can be retried
              local reason = err or load_err
              vim.notify(('treesitter: failed to install parser for %s%s'):format(lang, reason and (': ' .. tostring(reason)) or ''), vim.log.levels.WARN)
              return
            end
            start_all(lang)
          end)
        end)
      end
    end)
  end,
})

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
