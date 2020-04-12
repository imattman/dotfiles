" vimrc-settings.vim

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"


"
" color scheme
"

set t_Co=256
let g:gruvbox_contrast_dark = 'hard'          " hard | medium | soft
let g:gruvbox_contrast_light = 'hard'         " hard | medium | soft
"let g:molokai_original = 1
"let g:rehash256 = 1


if (has("termguicolors"))
  set termguicolors
endif

if has("gui_running")
  set background=dark                         " dark | light

  colorscheme jellybeans
"  colorscheme hybrid
"  colorscheme gruvbox
"  colorscheme dracula
"  colorscheme cobalt2
"  colorscheme molokai
"  colorscheme skittles_berry
"  colorscheme solarized
"  colorscheme sunburst
  let g:airline_theme = 'jellybeans'
"  let g:airline_theme = 'dracula'
"  let g:airline_theme = 'gruvbox'
"  let g:airline_theme = 'hybrid'
"  let g:airline_theme = 'tomorrow'
else
  set background=dark
  colorscheme gruvbox
"  colorscheme slate
endif


"set guifont=Monaco:h16
"set guifont=Menlo:h16
set guifont=Inconsolata:h18


" Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set ttyscroll=3                 " Speedup scrolling
set laststatus=2                " Show status line always

set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set smartindent                 "
set backspace=indent,eol,start  " Makes backspace key more powerful.

set number                      " Display numbers in left column
set ruler                       " Display cursor position in status line
set cursorline                  " Highlight cursor
set nocursorcolumn              " Do not highlight column (speeds up highlighting)

set visualbell                  " Use visual bell instead of audio
set noerrorbells                " No beeps
set t_vb=                       " Reset terminal code for visualbell for no flash
set lazyredraw                  " Wait to redraw

set noshowmode                  " Mode info handled by airline or lightline
set showcmd                     " Show me what I'm typing
set wildmenu                    " better commandline completion
set laststatus=2                " Always display the status line
set cmdheight=2                 " Set the command window height to 2 lines
set mouse=a                     " Enable use of the mouse for all modes

set confirm                     " Raise a dialog to confirm save when error occurs

syntax enable
syntax on

set listchars=tab:▸\ ,eol:¬    " Use the same symbols as TextMate for tabstops and EOLs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"set list                        " Show tabs and new lines
set showmatch                   " Show matching brackets by flickering
"set nowrap

" Search
set hlsearch                    " Highlight found searches
set incsearch                   " Shows the match while typing
set ignorecase                  " case insensitive search ...
set smartcase                   " ...unless capital letters used

set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

"" This enables us to undo files even if you exit Vim.
"if has('persistent_undo')
"  set undofile
"  set undodir=~/.config/vim/tmp/undo//
"endif


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""
nnoremap Y y$                   " Act like D and C

imap jj <ESC>                   " map 'jj' as easy alternate to ESC from insert mode

" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ","
noremap \ ,

" next search
nnoremap <C-L> :nohl<CR><C-L>   " Map redraw screen to also turn off highlighting

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>


" Jump to next error with Ctrl-n and previous error with Ctrl-p. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzz
"nnoremap n nzzzv
nnoremap N Nzz
"nnoremap N Nzzzv


" ------------------------------------------------------

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

" easier navigation
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


if has("autocmd")
  " Enter automatically into the files directory
  autocmd BufEnter * silent! lcd %:p:h

  autocmd BufNewFile,BufRead *.md setfiletype markdown

endif


"
" Plug in configuration loaded after main settings
"

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\ %{fugitive#statusline()}

" airline theme set above with colorscheme
let g:airline_enable_branch = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


" "------------------------------------------------------------
" "" NERDTree configuration
" let g:NERDTreeChDirMode=2
" let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
" let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
" let g:NERDTreeShowBookmarks=1
" let g:nerdtree_tabs_focus_on_files=1
" let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
" let g:NERDTreeWinSize = 30

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"nnoremap <silent> <F2> :NERDTreeFind<CR>
"noremap <F3> :NERDTreeToggle<CR>
"noremap <leader>nt :NERDTreeToggle<CR>
"noremap <leader>kb :NERDTreeToggle<CR>


"------------------------------------------------------------
"" Git
noremap <leader>ga :!git add .<CR>
"noremap <leader>gc :!git commit -m '<C-R>="'"<CR>
"noremap <leader>gsh :!git push<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
"noremap <leader>gr :Gremove<CR>




