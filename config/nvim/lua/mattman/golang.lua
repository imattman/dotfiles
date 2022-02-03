local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local keymap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

require'lspconfig'.gopls.setup{
  capabilities = capabilities,

  on_attach = function(client, bufnr)
    -- old keymap style for neovim < v0.7
    -- mappings require a <CMD> as string
    keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover<CR>", opts)
    keymap(bufnr, "n", "gd", "<CMD>lua vim.lsp.buf.definition<CR>", opts)
    keymap(bufnr, "n", "gt", "<CMD>lua vim.lsp.buf.type_definition<CR>", opts)
    keymap(bufnr, "n", "gi", "<CMD>lua vim.lsp.buf.implementation<CR>", opts)
    keymap(bufnr, "n", "]d", "<CMD>lua vim.diagnostic.goto_next<CR>", opts)
    keymap(bufnr, "n", "[d", "<CMD>lua vim.diagnostic.goto_prev<CR>", opts)
    keymap(bufnr, "n", "<leader>dn", "<CMD>lua vim.diagnostic.goto_next<CR>", opts)
    keymap(bufnr, "n", "<leader>dp", "<CMD>lua vim.diagnostic.goto_prev<CR>", opts)
    keymap(bufnr, "n", "<leader>dl", "<CMD>Telescope diagnostics<CR>", opts)
    keymap(bufnr, "n", "<leader>rn", "<CMD>lua vim.lsp.buf.rename<CR>", opts)
    keymap(bufnr, "n", "<leader>ca", "<CMD>lua vim.lsp.buf.code_action<CR>", opts)

    -- newer keymap style for neovim v0.7+
    --
--    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
--    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
--    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
--    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
--    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer=0})
--    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer=0})
--    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
--    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
--    vim.keymap.set("n", "<leader>dl", "<CMD>Telescope diagnostics<CR>", {buffer=0})
--    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0})
--    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})
    
  end,
}

