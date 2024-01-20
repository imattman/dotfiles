vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- bootstrap "lazy" package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}
local opts = {}

require("lazy").setup(plugins, opts)
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local tsconfigs = require("nvim-treesitter.configs")
tsconfigs.setup({
  ensure_installed = { "lua", "html", "javascript", "python" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
})


vim.api.nvim_create_augroup("markdown", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Set formatting options in Markdown files",
  group = "markdown",
  pattern = "*.md",
  -- format options:
  --   a - automatic formatting of paragraphs
  --   c - auto-wrap comments
  --   q - allow formatting comments with 'gq'
  --   t - auto-wrap text
  --   w - trailing whitespace indicates paragraph continues on next line
  -- command = "silent! setlocal spell formatoptions=acqt textwidth=80 colorcolumn=+1 wrap",
  command = "silent! setlocal spell formatoptions=cqt textwidth=80 colorcolumn=+1 wrap",
})

vim.api.nvim_create_augroup("journal", { clear = true })
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Set formatting options in journal files",
  group = "journal",
  pattern = "*/journal/daily/*",
  command = "silent! setlocal formatoptions=cqt spell wrap",
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Register keybind for journal formatting",
  group = "journal",
  command = "nnoremap <F5> :silent %!jn-fmt<CR>",
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Register keybind for journal format expansion",
  group = "journal",
  pattern = "*/journal/daily/*",
  command = "nnoremap <F6> :silent %!jn-fmt --expand<CR>",
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Register emojify keybind",
  group = "journal",
  pattern = "*/journal/daily/*",
  -- use 'E' register for location placeholder
  command = "nnoremap <F8> mE:silent %!emojify<CR>`E",
  -- command = "nnoremap <F8> :silent %!emojify<CR>G",
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Use local directory when editing journal files",
  group = "journal",
  pattern = "*/journal/daily/*",
  command = ":silent lcd %:p:h",
})

