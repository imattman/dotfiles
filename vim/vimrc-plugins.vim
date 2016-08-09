" Install Plug:
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"   Start VIM and run :PlugInstall


call plug#begin()
" Color schemes
Plug 'tomasr/molokai'
Plug 'shawncplus/skittles_berry'
Plug 'herrbischoff/cobalt2.vim'
Plug 'joshdick/onedark.vim'

Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/neocomplete.vim'
"Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'


" filetype plugins
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'corylanou/vim-present', {'for' : 'present'}

call plug#end()

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
"noremap <C-k><C-b> :NERDTreeToggle<CR>   " matches Sublime



"------------------------------------------------------------
"" Git
noremap <leader>ga :!git add .<CR>
"noremap <leader>gc :!git commit -m '<C-R>="'"<CR>
"noremap <leader>gsh :!git push<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
"noremap <leader>gr :Gremove<CR>


