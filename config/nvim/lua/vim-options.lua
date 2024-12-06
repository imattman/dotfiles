local options = {
  list = false,                            -- show whitespace characters
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  background = "dark",
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  cursorline = true,                       -- highlight the current line
  wrap = false,                            -- wrap long lines
  scrolloff = 2,
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
  -- softtabstop = 2,

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

  -- to select font:         :set guifont=*
  -- paste current value:    <C-r> =&guifont
  guifont = "Hack Nerd Font Mono:h16",     -- the font used in GUI
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>h", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<esc>", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { silent = true })

-- split windows
vim.keymap.set("n", "<C-h>", "<C-W>h<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-W>j<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-W>k<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-W>l<CR>", { silent = true })

-- Visual mode --
-- stay in indent mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- move text up and down
--vim.keymap.set("v", "<A-j>", ":m .+1<CR>==gv", { silent = true })
--vim.keymap.set("v", "<A-k>", ":m .-2<CR>==gv", { silent = true })
vim.keymap.set("v", "p", '"_dP', { silent = true }) -- paste without clobbering default register

-- increment/decrement numbers in a column
vim.keymap.set("x", "<C-a>", "<C-a>gv", { silent = true })
vim.keymap.set("x", "<C-x>", "<C-x>gv", { silent = true })


