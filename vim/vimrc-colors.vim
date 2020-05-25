" vimrc-colors.vim

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


" Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

