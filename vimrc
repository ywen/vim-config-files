" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 
set nocompatible
:au FocusLost * :wa
set t_Co=256
" autosave buffers
set autowriteall
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
set spell
" Don't use Ex mode, use Q for formatting
map Q gq
" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif
let g:Tex_ViewRule_pdf = 'Skim.app'

au BufRead,BufNewFile *.js set ft=javascript.jquery
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
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A

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

" Run Rspec for the current spec file
function! RunRspec()
ruby << EOF
  buffer = VIM::Buffer.current
  spec_file = VIM::Buffer.current.name
  VIM::message "Running Rspec for #{spec_file}. Results will be displayed in Firefox."
  command = "ruby ~/.vim/bin/run_rspec.rb #{spec_file}"
  system(command)
EOF
endfunction
map <F7> :call RunRspec()<cr>
map <D-r> <ESC>:w<CR><F7><CR>
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

"Rails
autocmd User Rails		Rnavcommand form app/forms -glob=**/*
autocmd User Rails		Rnavcommand presenter app/presenter -glob=**/*
autocmd User Rails		Rnavcommand plugin vendor/plugins -glob=**/*
autocmd User Rails		Rnavcommand stepdef features/step_definitions -glob=**/* -suffix=_steps.rb

"fuzzyfinder textmate style
map <leader>t :FuzzyFinderTextMate<CR>
