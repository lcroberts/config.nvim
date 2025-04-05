return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'saghen/blink.cmp',
    {
      'williamboman/mason.nvim',
      event = 'VeryLazy',
      opts = {},
    },
    {
      'j-hui/fidget.nvim',
      event = 'VeryLazy',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
  },
  config = function()
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local vmap = function(keys, func, desc)
          vim.keymap.set('v', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local imap = function(keys, func, desc)
          vim.keymap.set('i', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rn', function()
          vim.lsp.buf.rename()
        end, '[R]e[n]ame')

        map('<leader>ca', function()
          vim.lsp.buf.code_action()
        end, '[C]ode [A]ction')
        vmap('<leader>ca', function()
          vim.lsp.buf.code_action()
        end, '[C]ode [A]ction')

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rr', '<cmd>LspRestart<cr>', 'Restart LSP')

        -- See `:help K` for why this keymap
        map('K', function()
          vim.lsp.buf.hover()
        end, 'Hover Documentation')

        -- Lesser used LSP functionality
        map('gD', function()
          vim.lsp.buf.declaration()
        end, '[G]oto [D]eclaration')

        -- Diagnostic
        map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
        map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
        map('<leader>df', vim.diagnostic.open_float, 'floating diagnostic message')
        map('<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

        imap('<M-h>', vim.lsp.buf.signature_help, 'Show signature help')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[t]oggle [i]nlay hints')
        end
      end,
    })
  end,
}
