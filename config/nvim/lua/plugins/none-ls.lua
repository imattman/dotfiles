return {
  "nvimtools/none-ls.nvim",
  enabled = false,  -- causes issues with markdown

  config = function()
    -- note: "none-ls" was forked from "null-ls" with remnants of the old name remaining
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.autopep8, -- python
        null_ls.builtins.formatting.isort,    -- python
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.jq,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
