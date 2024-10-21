return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    local tsconfigs = require("nvim-treesitter.configs")
    tsconfigs.setup({
      ensure_installed = {
        "bash",
        "go",
        "html",
        "javascript",
        "lua",
  --      "markdown",
        "python",
        "rust",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == "html" then
            return true
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            vim.notify(
              "File larger than 100KB; treesitter disabled for performance",
              vim.log.levels.WARN,
              {title = "Treesitter"}
            )
            return true
          end
        end
      },
      indent = { enable = true },
    })
  end
}

