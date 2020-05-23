" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
" call vundle#begin()
Plug 'dstein64/vim-startuptime'
Plug 'yegappan/greplace'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'timcharper/textile.vim'
Plug 'tpope/vim-haml'
Plug 'vim-ruby/vim-ruby'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-abolish'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'Raimondi/delimitMate'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-speeddating'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-endwise'
Plug 'bling/vim-bufferline'
Plug 'plasticboy/vim-markdown'
Plug 'Konfekt/FastFold'
Plug 'ervandew/supertab'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'tpope/vim-bundler'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-rake'
Plug 'ywen/snipmate.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lervag/vimtex'
Plug 'tmhedberg/matchit'
Plug 'AndrewRadev/vim-eco'
Plug 'mbbill/undotree'
Plug 'janko-m/vim-test'
Plug 'szw/vim-maximizer'
Plug 'vim-syntastic/syntastic'
Plug 'benmills/vimux'
Plug 'isRuslan/vim-es6'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'slim-template/vim-slim'
Plug 'LnL7/vim-nix'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'
Plug 'liuchengxu/vim-clap'
Plug '~/.vim/bundle/IndexedSearch'
" call vundle#end()
call plug#end()
syntax enable
set shell=/bin/zsh
set t_Co=256
" autosave buffers
set autowriteall
autocmd BufLeave,FocusLost * wall
set ignorecase
set smartcase
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
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
tnoremap <Esc> <C-\><C-n>:q!<CR>

let g:bufferline_echo = 0
let g:bufferline_fname_mod = ':gs?.*\/\ze.*\/??'
let g:airline#extensions#tabline#enabled = 0
" set statusline=%<%f%h%m%r%=%{strftime(\"%l:%M\")}\ %l,%c%V\ %P%{fugitive#statusline()}
colorscheme railscasts
"Git commands
noremap gs :Gstatus<CR>
noremap ggc :Gcommit<CR>
noremap gap :Git add -p<CR>
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
let g:Tex_ViewRule_pdf = 'Preview.app'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_html_tidy_ignore_errors = [ 'trimming empty' ]
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

let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|public'
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
if has("folding")
  nmap zuz <Plug>(FastFoldUpdate)
  let g:fastfold_savehook = 1
  let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
  let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
  let g:markdown_folding = 1
  let g:tex_fold_enabled = 1
  let g:vimsyn_folding = 'af'
  let g:xml_syntax_folding = 1
  let g:javaScript_fold = 1
  let g:sh_fold_enabled= 7
  let g:ruby_fold = 1
  let g:perl_fold = 1
  let g:perl_fold_blocks = 1
  let g:r_syntax_folding = 1
  let g:rust_fold = 1
  let g:php_folding = 1
  set foldenable
  set foldmethod=syntax
  set foldlevel=0
  set foldnestmax=2
  highlight Folded ctermbg=black ctermfg=cyan
  highlight FoldColumn ctermbg=black ctermfg=cyan
  " automatically open folds at the starting cursor position
  " autocmd BufReadPost .foldo!
  autocmd FileType gitcommit setlocal nofoldenable
endif
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
map <C-P> :Clap files<CR>
map <C-F> :Clap grep<CR>

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
au! BufRead,BufNewFile *.tsx   setfiletype typescript

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

nmap <C-C> :b#<bar>bd#<CR>

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
map <Leader>vra :vertical resize +5<CR>
map <Leader>vrs :vertical resize -5<CR>

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
function! FloatingStrategy(cmd)
  " Terminal Window
  let width = float2nr(&columns - (&columns * 2 / 6))
  let height = float2nr(&lines / 1.4)
  let opts = {
        \ 'relative': 'editor',
        \ 'row': 2,
        \ 'col': 4,
        \ 'width': width,
        \ 'height': height,
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  call termopen(a:cmd)
  startinsert
endfunction

let g:test#preserve_screen = 0
let g:test#custom_strategies = {'floating': function('FloatingStrategy')}
let g:test#strategy = 'vimux'
let g:rspec_command = "bundle exec rspec"
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

" set statusline=%<%f%h%m%r%=%{strftime(\"%l:%M\")}\ %l,%c%V\ %P%{fugitive#statusline()}
let g:ConqueTerm_Color = 1
let g:ConqueTerm_TERM = 'vt100'
let g:ConqueTerm_ReadUnfocused = 0
let g:ConqueTerm_CWInsert = 0

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

" FZF Floating Window {{{1

if exists('*nvim_create_buf')
  let $FZF_DEFAULT_OPTS='--layout=reverse'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = &lines / 2
    let width = float2nr(&columns - (&columns * 2 / 4))
    let col = float2nr((&columns - width) / 2)

    let opts = {
          \ 'relative': 'editor',
          \ 'row': &lines / 5,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height
          \ }

    call nvim_open_win(buf, v:true, opts)
  endfunction
endif
command! -nargs=+ -complete=file Rag call fzf#vim#ag_raw(<q-args>)

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

function! FloatingTerm()
  " Terminal Window
  let width = float2nr(&columns - (&columns * 2 / 6))
  let col = float2nr(&columns * 0.2)
  let height = float2nr(&lines / 1.4)
  let opts = {
        \ 'relative': 'editor',
        \ 'row': 2,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  terminal
  startinsert
endfunction
map <Leader>at :call FloatingTerm()<cr>
nmap <Leader>nf :NERDTreeFind<CR>
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
" autocmd VimEnter * wincmd p
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:airline_section_a = airline#section#create(['mode', 'iminsert'])
let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert'])
let g:airline_section_x = airline#section#create([])
let g:airline_section_y = airline#section#create([])
let g:airline_section_z = airline#section#create(['%p%%', 'linenr',  ':%v'])

let g:airline_mode_map = {
      \ '__' : '--',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V-L',
      \ '' : 'V-B',
      \ 's'  : 'S',
      \ 'S'  : 'S-L',
      \ '' : 'S-B',
      \ 't'  : 'T',
      \ }
