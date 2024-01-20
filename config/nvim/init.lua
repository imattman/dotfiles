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
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
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
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Configure emoji abbreviations",
  group = "markdown",
  pattern = "*.md",
  callback = function(event)
    vim.cmd("iabbrev :smile: 😄")
    vim.cmd("iabbrev :smile: 😄")
    vim.cmd("iabbrev :smiley: 😃")
    vim.cmd("iabbrev :slight_smile: 🙂")
    vim.cmd("iabbrev :grin: 😁")
    vim.cmd("iabbrev :grinning: 😀")
    vim.cmd("iabbrev :wink: 😉")
    vim.cmd("iabbrev :laughing: 😆")
    vim.cmd("iabbrev :rofl: 🤣")
    vim.cmd("iabbrev :cry: 😢")

    vim.cmd("iabbrev :thumbsup: 👍")
    vim.cmd("iabbrev :thumbsdown: 👎")
    vim.cmd("iabbrev :wave: 👋")

    vim.cmd("iabbrev :neutral_face: 😐")
    vim.cmd("iabbrev :frowning_face: ☹️ ")
    vim.cmd("iabbrev :slightly_frowning_face: 🙁")
    vim.cmd("iabbrev :tired_face: 😫")
    vim.cmd("iabbrev :raised_eyebrow: 🤨")
    vim.cmd("iabbrev :roll_eyes: 🙄")
    vim.cmd("iabbrev :open_mouth: 😮")
    vim.cmd("iabbrev :thinking: 🤔")
    vim.cmd("iabbrev :upside_down_face: 🙃")

    vim.cmd("iabbrev :stuck_out_tongue: 😛")
    vim.cmd("iabbrev :stuck_out_tongue_closed_eyes: 😝")
    vim.cmd("iabbrev :stuck_out_tongue_winking_eye: 😜")
    vim.cmd("iabbrev :blush: 😊")
    vim.cmd("iabbrev :zany_face: 🤪")
    vim.cmd("iabbrev :drooling_face: 🤤")
    vim.cmd("iabbrev :nerd_face: 🤓")
    vim.cmd("iabbrev :pleading_face: 🥺")
    vim.cmd("iabbrev :partying_face: 🥳")
    vim.cmd("iabbrev :zipper_mouth_face: 🤐")
    vim.cmd("iabbrev :angry: 😠")
    vim.cmd("iabbrev :rage: 😡")
    vim.cmd("iabbrev :cursing_face: 🤬")

    vim.cmd("iabbrev :facepalm: 🤦")
    vim.cmd("iabbrev :hugging: 🤗")
    vim.cmd("iabbrev :heart: ❤️ ")
    vim.cmd("iabbrev :kissing_heart: 😘")
    vim.cmd("iabbrev :heart_eyes: 😍")
    vim.cmd("iabbrev :clown_face: 🤡")
  end
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

