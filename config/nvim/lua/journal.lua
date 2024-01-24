vim.api.nvim_create_augroup("journal", { clear = true })
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Set formatting options in journal files",
  group = "journal",
  pattern = "*/journal/daily/*",
  command = "silent! setlocal formatoptions=acqt spell wrap joinspaces",
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

