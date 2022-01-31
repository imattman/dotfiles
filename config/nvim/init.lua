-- Neovim config heavily borrowed from lunarvim examples.
-- See: https://github.com/LunarVim/Neovim-from-scratch.git
--
-- Note: lua config files are implicitly resolved under the
--       "lua" directory.  The ".lua" extension is also implied.

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"

