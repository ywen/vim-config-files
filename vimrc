" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
execute pathogen#infect()
set nocompatible
set t_Co=256
" autosave buffers
set autowriteall
autocmd BufLeave,FocusLost * wall
set ignorecase
set smartcase
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set shell=/bin/bash
set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
setlocal spell spelllang=en_us
set spell
set number
set undofile
set undodir=~/.vim/undo
set gdefault
let mapleader = ","
"remove the search highlight
nnoremap <leader><space> :noh<cr>
inoremap jj <ESC>
"split window
nnoremap <leader>w <C-w>v<C-w>l
"move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <leader>a :Ack
"silly attempt to convert class name to underscore
nnoremap <leader>u :s/\(\u\)/_\L\1<cr>
set clipboard=unnamed
nnoremap j gj
nnoremap k gk
nnoremap ; :
" Don't use Ex mode, use Q for formatting
map Q gq

"Git commands
noremap gs :Gstatus<CR>
noremap ggc :Gcommit<CR>
noremap gp :Git push<CR>
" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp
"
"file jumping
noremap fb :b#<CR>

let ruby_space_errors = 1
set list!
set list listchars=tab:»·,trail:·
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif
let g:Tex_DefaultTargetFormat= "pdf"
let g:Tex_ViewRule_pdf = 'Skim.app'

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd BufNewFile,BufRead *.ctl setf ruby

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

set autoindent		" always set autoindenting on

endif " has("autocmd")
set directory=~/.vim/swp
" if has("folding")
"   set foldenable
"   set foldmethod=syntax
"   set foldlevel=1
"   set foldnestmax=2
"   set foldtext=strpart(getline(v:foldstart),0,50).'\\ ...\\ '.substitute(getline(v:foldend),'^[\\ #]*','','g').'\\ '
"   highlight Folded guibg=grey guifg=blue
"   highlight FoldColumn guibg=darkgrey guifg=white
"   " automatically open folds at the starting cursor position
"   " autocmd BufReadPost .foldo!
" endif
" 
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" Hide search highlighting
map ,nh :nohls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: ,e
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: ,t
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab
" imap <Tab> <C-N>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Display extra whitespace
" set list listchars=tab:»·,trail:·
let g:Conque_TERM = "xterm"

" Edit routes
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
set grepprg=grep\ -nH\ $*
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme railscasts
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A

autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set complete=.,w,b,u,t
set completeopt=longest,menu
set wildmode=list:longest,list:full

" Mappings
" run one rspec example or describe block based on cursor position
" map <D-r> <ESC>:w<CR>:RunSpec<CR>
map <D-B> <ESC>:BufOnly<cr>
function! RailsScriptSearch(args)
  let l:savegrepprg = &grepprg  
  let l:savegrepformat = &grepformat

  try
    set grepprg=script/find
    set grepformat=%f:%l:%m

    execute "grep " . a:args
  finally
    execute "set grepformat=" . l:savegrepformat
    execute "set grepprg=" . l:savegrepprg
  endtry
endfunction

" search with explicitly provided arguments
command! -n=? Rgrep :call RailsScriptSearch('<args>')

" search for the word under the cursor
map <leader>rg :silent call RailsScriptSearch(expand("'<cword>'"))<CR>:cc<CR>

" search for the method definition of the word under the cursor
map <leader>rd :silent call RailsScriptSearch(expand("'def <cword>'"))<CR>:cc<CR>
" TextMate cmd+T mode

"ruby
" autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold guibg=#9aadd5 guifg=black
augroup mkd

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;

augroup END

set statusline=%<%f%h%m%r%=%{strftime(\"%l:%M\")}\ %l,%c%V\ %P%{fugitive#statusline()}
let g:ConqueTerm_Color = 1
let g:ConqueTerm_TERM = 'vt100'
let g:ConqueTerm_ReadUnfocused = 0
let g:ConqueTerm_CWInsert = 0

let g:bufferline_rotate = 2

"rails.vim specific shortcut
noremap <leader>rm :Rmodel 
noremap <leader>rc :Rcontroller 
noremap <leader>rv :Rview 
noremap <leader>rs :Rspec 
noremap <leader>rl :Rlib 
noremap t :A<CR>

"buffers
noremap <leader>bd :bd<CR>
let g:SimpleJsIndenter_BriefMode = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_TERM = 'xterm'
"mouse support in terminal
set mouse=a
set mousehide

"gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-o> :call NumberToggle()<cr>

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

let g:rails_projections = {
	      \ "app/classes/commands/*.rb": {
	      \   "command": "commands",
	      \   "test": [
	      \     "spec/classes/commands/%s_spec.rb"
	      \   ],
	      \   "keywords": "commands"
        \ },
	      \ "app/classes/forms/*.rb": {
	      \   "command": "forms",
	      \   "test": [
	      \     "spec/classes/forms/%s_spec.rb"
	      \   ],
	      \   "keywords": "forms"
        \ },
	      \ "app/classes/policies/*.rb": {
	      \   "command": "policies",
	      \   "test": [
	      \     "spec/classes/policies/%s_spec.rb"
	      \   ],
	      \   "keywords": "forms"
        \ },
	      \ "app/classes/decorators/*.rb": {
	      \   "command": "decorator",
	      \   "test": [
	      \     "spec/classes/decorators/%s_spec.rb"
	      \   ],
	      \   "keywords": "decorator"
        \ }
        \}
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")

