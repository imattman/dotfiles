local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.gopls.setup{
  capabilities = capabilities,

  on_attach = function() 
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<leader>dl", "<CMD>Telescope diagnostics<CR>", {buffer=0})
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})

    --vim.keymap.set("n", "<C-_>", "<CMD>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>", {buffer=0})
    
  end,
}

