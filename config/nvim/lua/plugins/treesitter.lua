return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    local tsconfigs = require("nvim-treesitter.configs")
    tsconfigs.setup({
      ensure_installed = { "lua", "html", "javascript", "python" },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
