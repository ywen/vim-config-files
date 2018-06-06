" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'timcharper/textile.vim'
Plugin 'tpope/vim-haml'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rking/ag.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-abolish'
Plugin 'pangloss/vim-javascript'
Plugin 'Raimondi/delimitMate'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-endwise'
Plugin 'bling/vim-bufferline'
Plugin 'plasticboy/vim-markdown'
Plugin 'ervandew/supertab'
Plugin 'schickling/vim-bufonly'
Plugin 'tpope/vim-surround'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-bundler'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-dispatch'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-rake'
Plugin 'ywen/snipmate.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'lervag/vimtex'
Plugin 'tmhedberg/matchit'
Plugin 'AndrewRadev/vim-eco'
Plugin 'mbbill/undotree'
Plugin 'janko-m/vim-test'
Plugin 'szw/vim-maximizer'
Plugin 'vim-syntastic/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'benmills/vimux'
Plugin 'isRuslan/vim-es6'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'dhruvasagar/vim-railscasts-theme'
Plugin 'slim-template/vim-slim'
Plugin 'file://~/.vim/bundle/IndexedSearch'
call vundle#end()
syntax enable
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
nnoremap <leader>v <C-w>s<C-w>l
"move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"silly attempt to convert class name to underscore
nnoremap <leader>u :s/\(\u\)/_\L\1<cr>
set clipboard=unnamed
nnoremap j gj
nnoremap k gk
nnoremap ; :
" Don't use Ex mode, use Q for formatting
map Q gq

colorscheme railscasts
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
let g:jsx_ext_required = 0
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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

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

let g:livepreview_previewer = 'open -a Skim'

" Maps autocomplete to tab
" imap <Tab> <C-N>
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "ywen.snippets"]
"
" let g:UltiSnipsExpandTrigger="<S-Tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

nmap <C-C> <Plug>Kwbd

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
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A

autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Numbers
set number
set numberwidth=5

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set complete=.,w,b,u,t
set completeopt=longest,menu
set wildmode=list:longest,list:full
" Mappings
" run one rspec example or describe block based on cursor position
" map <D-r> <ESC>:w<CR>:RunSpec<CR>
let NODE_ENV = "test"
let g:rspec_runner = "os_x_iterm2"
let test#strategy = "dispatch"
let g:rspec_command = "Dispatch bundle exec rspec"
let test#ruby#cucumber#executable = "bundle exec spinach"
let test#ruby#cucumber#options= '-b'
let test#javascript#mocha#executable = 'yarn test --reporter dot'

map <Leader>t :TestFile<CR>
map <Leader>s :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>g :TestVisit<CR>

map <C-b> <ESC>:BufOnly<cr>
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
noremap <Leader>ot :vsplit<ENTER><C-w>l:A<ENTER>
"buffers
noremap <leader>bd :bd<CR>
let g:SimpleJsIndenter_BriefMode = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_TERM = 'xterm'
"mouse support in terminal
set mouse=a
set mousehide
set noswapfile

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
	      \ "features/*.feature": {
	      \   "command": "features",
	      \   "keywords": "features",
	      \   "test": [
	      \     "features/steps/{}.rb",
	      \   ],
        \ },
	      \ "features/steps/*.rb": {
	      \   "command": "steps",
	      \   "keywords": "steps",
	      \   "test": [
	      \     "features/{}.feature",
	      \   ],
        \ },
	      \ "app/controllers/api/v1/*_controller.rb": {
	      \   "command": "vapi",
	      \   "keywords": "vapi",
	      \   "test": [
	      \     "spec/controllers/api/v1/%s_spec.rb",
	      \   ],
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
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>r :call RenameFile()<cr>
hi! DiffAdd      guibg=#003300
hi! DiffChange   guibg=#003300
hi! DiffDelete   guifg=#330000 guibg=#330000
hi! DiffText     guibg=#990000    
