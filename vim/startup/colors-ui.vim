" color scheme

set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1

if has("gui_running")
  colorscheme skittles_berry
"  colorscheme molokai
"  colorscheme sunburst
"  colorscheme solarized
else
  set background=dark
  colorscheme slate
endif


"set guifont=Monaco:h14
set guifont=Inconsolata:h18


" Invisible character colors 
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

