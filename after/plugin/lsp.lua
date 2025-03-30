vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', '<CMD>Lspsaga goto_definition<CR>', 'goto definition')
    map('gi', '<CMD>Lspsaga finder imp<CR>', 'goto implementation')
    map('gr', '<cmd>Lspsaga finder<CR>', 'Search references')
    map('gp', '<cmd>Lspsaga peek_definition<CR>', 'Peek definition')
    map('gtp', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type definition')
    map('gtd', '<cmd>Lspsaga goto_type_definition<CR>', 'Type definition')

    map('[d', '<CMD>Lspsaga diagnostic_jump_prev<CR>', 'jump to previous diagnostics')
    map(']d', '<CMD>Lspsaga diagnostic_jump_next<CR>', 'jump to next diagnostics')

    map('K', function() vim.lsp.buf.hover() end, 'show doc') -- use noice here

    map('<leader>lc', '<cmd>Lspsaga incoming_calls<CR>', 'Incoming calls')
    map('<leader>lC', '<cmd>Lspsaga outgoing_calls<CR>', 'Outgoing calls')
    map('<leader>la', '<cmd>Lspsaga code_action<CR>', 'LSP code action')
    map('<leader>lS', '<cmd>Lspsaga outline<CR>', 'Symbols outline')
    map('<leader>lr', '<cmd>Lspsaga rename<CR>', 'Symbols rename')
    map('<leader>ld', function()
      vim.diagnostic.open_float()
    end, 'Hover diagnostic')

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>lH', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle Inlay Hints')
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities
})

local lsps = { "clangd", "basedpyright", "luals", "bashls", "nil", "neocmake", "sourcekit" }

for _, lsp in ipairs(lsps) do
  if vim.fn.executable(vim.lsp.config[lsp].cmd[1]) == 1 then
    vim.lsp.enable(lsp)
  end
end

-- lspconfig['tinymist'].setup { capabilities = capabilities }
-- -- lspconfig['marksman'].setup { capabilities = capabilities }
-- lspconfig['bashls'].setup { capabilities = capabilities }
-- lspconfig['svls'].setup { capabilities = capabilities }
-- lspconfig['matlab_ls'].setup {
--   capabilities = capabilities,
--   single_file_support = true,
--   settings = {
--     MATLAB = {
--       indexWorkspace = false,
--       installPath = "",
--       matlabConnectionTiming = "onStart",
--       telemetry = true,
--     }
--   },
-- }
-- -- lspconfig['harper_ls'].setup { capabilities = capabilities }
