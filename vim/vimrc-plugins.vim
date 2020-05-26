" Install Plug:
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"   Start VIM and run :PlugInstall
"
"   Maintenance and updates:
"
"     PlugUpgrade
"     PlugUpdate
"     PlugClean  (remove unused / incorrect plugins)
"

call plug#begin()
" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'gosukiwi/vim-atom-dark'
Plug 'herrbischoff/cobalt2.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'shawncplus/skittles_berry'
Plug 'w0ng/vim-hybrid'

"
" General plugins
"

" Snippet engine and snippet content
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" File find and content search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'janko/vim-test'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'Shougo/neocomplete.vim'
"Plug 'majutsushi/tagbar'

"
" filetype plugins
"
Plug 'tpope/vim-markdown'
" formatting markdown tables
Plug 'junegunn/vim-easy-align'

Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
"Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'corylanou/vim-present', {'for' : 'present'}

call plug#end()




