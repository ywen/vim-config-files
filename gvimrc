" Window size
set winwidth=50
let g:halfsize = 120
let g:fullsize = 120
set lines=40
let &columns = g:halfsize

" Font
set guifont=Menlo:h18.00

set fuoptions=maxhorz,maxvert,background:Normal

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c
hi normal guibg=black
set transp=7

if has("gui_macvim")
  map mm <Plug>PeepOpen
end

nmap <D-Right> :maca _cycleWindowsBackwards:<CR>
nmap <D-Left> :maca _cycleWindows:<CR>

