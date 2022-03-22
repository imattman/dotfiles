-- Matt's neovim config  -- heavily borrowed from LunarVim example

--------------------------------------------------
-- plugins
--------------------------------------------------
require "mattman.plugins"
require "mattman.colorscheme"
require "mattman.cmp"
require "mattman.telescope"
require "mattman.treesitter"
require "mattman.autocommands"
require "mattman.golang"


--------------------------------------------------
-- general options
-- TODO: move this to separate "options.lua"?
--
-- the following values are assigned to 'vim.opt' below
--------------------------------------------------

local options = {
  list = false,                            -- show whitespace characters
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  background = dark,
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  cursorline = true,                       -- highlight the current line
  wrap = false,                            -- wrap long lines
  scrolloff = 4,
  sidescrolloff = 4,
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  pumheight = 10,                          -- pop up menu height
  showmode = true,                         -- display mode, e.g. "INSERT"
  showtabline = 2,                         -- always show tabs
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window

  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab

  mouse = "a",                             -- allow the mouse to be used in neovim
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  fileencoding = "utf-8",                  -- the encoding written to a file
  confirm = true,
  backup = false,                          -- creates a backup file
  swapfile = false,                        -- creates a swapfile
  undofile = false,                        -- enable persistent undo
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files

  timeoutlen = 400,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                        -- faster completion (4000ms default)
  autoread = true,                         -- automatically read changed files

  listchars= { tab='» ', trail='·', nbsp='␣', eol='¬' },
  --listchars= { tab='▸ ', eol='¬' },

  -- to select font:         :set guifont=*
  -- paste current value:    <C-r> =&guifont
  guifont = "Hack Nerd Font Mono:h16",     -- the font used in GUI
}

vim.opt.shortmess:append "c"

-- vim.o    global options
-- vim.wo   options local to window
-- vim.bo   options local to buffer

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work


--------------------------------------------------
-- keybinds
--------------------------------------------------

-- alias function for less typing
local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- use spacebar as leader key
--keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mode --

keymap("n", "<Leader>e", ":Lexplore 25<CR>", opts)

-- set local CWD to that of current buffer
keymap("n", "<Leader>cd", ":lcd %:p:h<CR>", opts)

-- telescope
keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<C-f>", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "<Leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<Leader>fg", "<CMD>Telescope git_files<CR>", opts)
keymap("n", "<Leader>fb", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "<Leader>gc", "<CMD>Telescope git_commits<CR>", opts)
keymap("n", "<C-_>", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy='ascending', prompt_position='top'})<CR>", opts)


-- better window navigation
--keymap("n", "<C-h>", "<C-w>h", opts)
--keymap("n", "<C-j>", "<C-w>j", opts)
--keymap("n", "<C-k>", "<C-w>k", opts)
--keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-w><C-^>", ":vsplit #<CR>", opts)
keymap("n", "<C-w><C-6>", ":vsplit #<CR>", opts)
keymap("n", "<C-w>6", ":vsplit #<CR>", opts)

-- emacs habit
keymap("n", "<C-w>0", "<C-w>o", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- navigate buffers
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
--keymap("n", "<Leader>n", ":bnext<CR>", opts)
--keymap("n", "<Leader>p", ":bprevious<CR>", opts)

keymap("n", "<Leader>6", "<C-^>", opts)   -- easy toggle between alternate file
--keymap("n", "<Leader> ", "<C-^>", opts)

-- turn off hlsearch
keymap("n", "<Leader>l", "<CMD>nohl<CR>", opts)

-- quickfix navigation
keymap("n", "<C-n>", "<CMD>cnext<CR>", opts)
keymap("n", "<C-m>", "<CMD>cprev<CR>", opts)

-- Move text up and down
-- MacOS requires unbind current <Option> input behavior
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert mode --
-- press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual mode --
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


