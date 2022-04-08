vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted

    " change local directory to that of buffer
    "autocmd BufEnter * silent! lcd %:p:h
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal textwidth=80 colorcolumn=+1

    "a - automatic formatting of paragraphs
    "c - auto-wrap comments
    "q - allow formatting comments with 'gq'
    "t - auto-wrap text
    "w - trailing whitespace indicates paragraph continues on next line
    autocmd FileType markdown setlocal formatoptions=cqt

    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal wrap
  augroup end

  augroup _journal
    autocmd!
    "autocmd BufRead,BufNewFile */journal/daily/* set formatprg=jn-fmt
    autocmd BufRead,BufNewFile */journal/daily/*  nnoremap <F5> :%!jn-fmt<CR>
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
