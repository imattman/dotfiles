" Plug in configuration loaded after main settings
"
" See vimrc-plugins.vim for list of plug-ins


set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\ %{fugitive#statusline()}

"let g:airline_theme = 'powerlineish'
let g:airline_enable_branch = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


"------------------------------------------------------------
"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>
noremap <leader>nt :NERDTreeToggle<CR>
noremap <leader>kb :NERDTreeToggle<CR>


"------------------------------------------------------------
"" Git
noremap <leader>ga :!git add .<CR>
"noremap <leader>gc :!git commit -m '<C-R>="'"<CR>
"noremap <leader>gsh :!git push<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
"noremap <leader>gr :Gremove<CR>

