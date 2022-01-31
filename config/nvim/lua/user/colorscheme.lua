vim.cmd [[
try
  colorscheme spacedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

