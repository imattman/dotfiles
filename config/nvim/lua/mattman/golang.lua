local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

-- copied from gopls docs
-- function goimports(timeoutms)
--   local context = { source = { organizeImports = true } }
--   vim.validate { context = { context, "t", true } }
-- 
--   local params = vim.lsp.util.make_range_params()
--   params.context = context
-- 
--   local method = "textDocument/codeAction"
--   local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
--   if resp and resp[1] then
--     local result = resp[1].result
--     if result and result[1] then
--       local edit = result[1].edit
--       vim.lsp.util.apply_workspace_edit(edit)
--     end
--   end
-- 
--   vim.lsp.buf.formatting()
-- end


-- following example solution from github issue:
--   https://github.com/neovim/nvim-lspconfig/issues/115
function goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        -- note: text encoding param is required
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd [[
augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
	autocmd BufWritePre *.go :silent! lua goimports(3000)
augroup END
]]

-- vim.cmd [[
--   augroup _go
--     autocmd!
--     au! BufWritePre <buffer>
--     autocmd BufWritePre *.go lua goimports(1000)
--   augroup end
-- ]]
    -- autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync(nil, 500)

