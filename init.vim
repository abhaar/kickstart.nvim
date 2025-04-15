" Disable vi compatibility when overriding default vimrc via -u
set nocompatible

" Do not use backup files in /private/tmp (fixes crontab editing in OS X)
set backupskip+=/private/tmp/*

" Place all swap files in one location; trailing // ensures uniqueness
set directory^=~/.vim/swap//

" Hide abandoned buffers instead of unloading them
" To list buffers use :ls or :buffers
" To close a buffer use :bdelete <number>
" To navigate buffers, use :bn, :bp, :b #, :b name, ctrl-6
set hidden

" Automatically read files changed outside of vim
set autoread

" Enable mouse in all modes
set mouse=a

" Shorten all file messages; do not display the intro message
set shortmess+=aI

" Save more command-line history
set history=1000

" Search upward for a tags file
set tags+=tags;

" Ignore temporary and output files
set wildignore+=*.class,*.o,*.out,*.pyc,*.swp,*~

" Complete to the longest common prefix first, then list all completions
"set wildmode=longest,list

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

" Always report the number of lines changed by a command
set report=0

" Show partial commands
set showcmd

" Split below/right instead of above/left
set splitbelow splitright

" Always show the status line
set laststatus=2

" File name, flags (modified, read-only, help, preview), and file type
set statusline=%t%m%r%h%w\ %y%{&ft!=''?'\ ':''}

" File format and encoding; noeol; truncate right; switch to right alignment
set statusline+=[%{&ff},%{&fenc!=''?&fenc:&enc}]%{&eol?'':'\ [noeol]'}\ %<%=

" Character under cursor in decimal and hexadecimal
set statusline+=[%03b,0x%02B]

" Line, total lines, column, virtual column, and display width
set statusline+=\ [%l/%L,%c%V/%{strdisplaywidth(getline('.'))}]

" Percent of file (line / total lines) and percent of file (displayed window)
set statusline+=\ [%p%%,%P]

" Show line numbers
set number

if exists('+relativenumber')
  " Use relative line numbers
  set relativenumber
endif

" Display parts of wrapped lines that are cut off at the bottom
set display=lastline

" Do not split words when wrapping long lines
set linebreak

" Default to 2 spaces per tab
set shiftwidth=2 expandtab smarttab

" Round to the nearest tab when indenting; copy indentation exactly
set shiftround autoindent copyindent

" Toggle paste mode
"set pastetoggle=<F2>

if has('clipboard')
  " Interact with the X clipboard
  set clipboard=unnamed
endif

" Default to # comments, not C-style
set commentstring=#\ %s

" Always allow backspacing
set backspace=indent,eol,start

" Do not automatically add EOL at EOF
set nofixeol

" Insert 1 space (not 2) between sentences when joining
set nojoinspaces

" Do not move the cursor to the first non-blank when jumping
set nostartofline

" Search incrementally; highlight matches; ignore case iff all lowercase
set incsearch hlsearch ignorecase smartcase

" Leader
let mapleader = "\<Space>"

" Prefer jumping directly to marks
nnoremap ' `
xnoremap ' `
onoremap ' `
nnoremap ` '
xnoremap ` '
onoremap ` '

" Yank until EOL; matches the behavior of C and D
nnoremap Y y$

" Black hole register
nnoremap \ "_
xnoremap \ "_

" Remain in visual mode after shifting lines
xnoremap < <gv
xnoremap > >gv

" Sane line nav in wrapped lines
noremap j gj
noremap k gk

" Write buffer
nnoremap <Leader><CR> :write<CR>

" "ZZ all" and quit vim with a non-zero exit code, respectively
nnoremap ZA :xall<CR>
nnoremap ZC :cquit<CR>

" Repeat the last change [count] times instead of replacing the original count
nnoremap <silent> . :<C-u>exe 'norm! ' . repeat('.', v:count1)<CR>

" List, switch, create, and delete buffers
nnoremap <Leader>b :buffers<CR>:b
nnoremap <Leader>h :split<CR>
nnoremap <Leader>H :leftabove split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>V :leftabove vsplit<CR>
nnoremap <Leader>c :bp\|:bd #<CR>
nnoremap <Leader>C :bp\|:bd! #<CR>

" Navigate and close windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-c> <C-w>c

" Jump to tag under cursor in split window
nnoremap <C-\> <C-w>s<C-]>

" Temporarily disable search highlighting
nnoremap <Leader>/ :nohlsearch<CR>

" Remove all trailing whitespace
nnoremap <Leader>w :keeppatterns %s/\s\+$//<CR>

" Match all characters past column 79 or 80 or 99 or 100
nmap <Leader>7 /\%80c.\+<CR>
nmap <Leader>8 /\%81c.\+<CR>
nmap <Leader>9 /\%100c.\+<CR>
nmap <Leader>0 /\%101c.\+<CR>

nmap <Leader>f :GFiles<CR>

let g:python_host_prog = '/usr/bin/python' "Python2
let g:python3_host_prog = '/usr/bin/python3' "Python3

" Load filetype plugins and indentation files
filetype plugin indent on

if has('autocmd')
  augroup vimrc
    " Remove all autocommands from this group
    autocmd!

    " Disable paste mode when leaving insert mode
    autocmd InsertLeave * set nopaste

    " Override default indentation settings
    autocmd FileType gitconfig,make,snippets,sshconfig setlocal sw=8 noet

    " Turn on spell checking for git commits
    autocmd FileType gitcommit set spell

    " Limit text width
    autocmd FileType markdown,text setlocal textwidth=80
    autocmd FileType python setlocal textwidth=79

    " Revert to global wrap setting in diff mode
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif

    " Resize windows when vim is resized
    autocmd VimResized * wincmd =

    " Use MYSQL syntax for sql files
    autocmd FileType sql :SQLSetType mysql.vim
  augroup end
endif

if filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
  call plug#begin()

  " Exploration
  " nerdtree seems to contibute 18 ms to start up time, more than any other
  " plugin, but it's nice to have
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1

  " Status bar
  " This requires a patched font: https://github.com/wernight/powerline-web-fonts
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_powerline_fonts = 1

  " Movement
  Plug 'easymotion/vim-easymotion'

  " Terraform
  Plug 'hashivim/vim-terraform'
  let g:terraform_align=1
  let g:terraform_fmt_on_save=1

  " Clipboard copying util
  Plug 'fcpg/vim-osc52'

  " Colors
  Plug 'chriskempson/base16-vim'

  " Various useful commands and functions
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'christoomey/vim-sort-motion'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " Code search
  Plug 'rking/ag.vim'

  " Auto-formatting C, C++, Obj-C, Java, JavaScript, TypeScript and ProtoBuf
  Plug 'rhysd/vim-clang-format'
  let g:clang_format#command='clang-format-15'
  let g:clang_format#auto_format=0

  " Fuzzy file search
  "let g:ctrlp_working_path_mode = ''
  "let g:ctrlp_show_hidden = 1
  "let g:ctrlp_clear_cache_on_exit = 0
  "let g:ctrlp_lazy_update = 10
  "let g:ctrlp_user_command = ['.git', 'git ls-files --cached --others --exclude-standard -- %s']
  "let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
  "Plug 'nixprime/cpsm', {'do': 'PY3=ON ./install.sh'}
  "Plug 'ctrlpvim/ctrlp.vim'

  " Git commands and signs
  Plug 'tpope/vim-fugitive'
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gdiff HEAD^<CR>
  let g:signify_vcs_cmds = {'git': 'git diff --no-color --no-ext-diff -U0 HEAD^ -- %f'}
  Plug 'mhinz/vim-signify'
  hi! link SignifySignAdd Function
  hi! link SignifySignChange String
  hi! link SignifySignDelete Statement
  hi! link SignifySignChangeDelete Identifier

  " Indentation detection
  Plug 'tpope/vim-sleuth'

  " Auto format js-like files
  Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

  " max line length that prettier will wrap on
  " Prettier default: 80
  let g:prettier#config#print_width = 80

  " Snippets engine
  Plug 'SirVer/ultisnips'
  " Many useful snippets
  Plug 'honza/vim-snippets'

  " Search
  Plug 'junegunn/vim-slash'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'


  " Syntax checking
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': ['python']}
  let g:syntastic_python_checkers = ['pyflakes']
  Plug 'scrooloose/syntastic'

  " Syntax highlighting
  Plug 'jparise/vim-graphql'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_metalinter_autosave = 0
  let g:go_def_mode = "gopls"
  " let g:go_metalinter_command = 'gometalinter --config /data/data/com.termux/files/home/go/src/github.com/anchorlabsinc/anchorage/gometalinter.json'
  let g:syntastic_go_checkers = ['gometalinter']
  "let g:syntastic_go_gometalinter_args = ['--config', '/data/data/com.termux/files/home/go/src/github.com/anchorlabsinc/anchorage/gometalinter.json']
  "let g:go_auto_sameids = 1
  "let g:go_fmt_options = {
  "  \ 'gofmt': '-s',
  "  \ }
  let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ 'goimports': '-local github.com/anchorlabsinc/anchorage',
    \ }
  let g:go_fmt_command = "goimports"
  let g:go_fmt_autosave = 1

  " Set the Go Guru Scope to be git root path + /...
  " This should work with any other projects and replicates the behavior or
  " projectile in emacs. Taken from https://github.com/fatih/vim-go/issues/1037#issuecomment-434949725
  function! s:go_guru_scope_from_git_root()
    let gitroot = system("git rev-parse --show-toplevel | tr -d '\n'")
    let pattern = escape(go#util#gopath() . "/src/", '\ /')
    return substitute(gitroot, pattern, "", "") . "/... -vendor/"
  endfunction

  au FileType go silent exe "GoGuruScope " . s:go_guru_scope_from_git_root()
  au FileType go nmap <Leader>m <Plug>(go-implements)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>e <Plug>(go-rename)

  " go stuff
  set tabstop=4

  " tag bar
   " Tags
  Plug 'majutsushi/tagbar'
  nmap <F8> :TagbarToggle<CR>

  " Rust plugins
  Plug 'rust-lang/rust.vim'

  " auto complete

  " Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

  " Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py  --clangd-completer' }

  "if has('nvim')
  "  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "else
  "  Plug 'Shougo/deoplete.nvim'
  "  Plug 'roxma/nvim-yarp'
  "  Plug 'roxma/vim-hug-neovim-rpc'
  "endif

  "Plug 'zchee/deoplete-go'

  "" neocomplete like
  "set completeopt+=noinsert
  "" deoplete.nvim recommend
  "set completeopt+=noselect

  """ Use deoplete.
  "let g:deoplete#enable_at_startup = 1

  "let g:deoplete#sources#go#source_importer = 1
  "let g:deoplete#sources#go#builtin_objects = 1


  "" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
  "Plug 'ncm2/ncm2'
  "Plug 'roxma/nvim-yarp'

  "" enable ncm2 for all buffers
  "autocmd BufEnter * call ncm2#enable_for_buffer()

  "" IMPORTANTE: :help Ncm2PopupOpen for more information
  "set completeopt=noinsert,menuone,noselect

  "" NOTE: you need to install completion sources to get completions. Check
  "" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
  "Plug 'ncm2/ncm2-bufword'
  "Plug 'ncm2/ncm2-tmux'
  "Plug 'ncm2/ncm2-path'
  "Plug 'ncm2/ncm2-go'

  "" When the <Enter> key is pressed while the popup menu is visible, it only
  "" hides the menu. Use this mapping to close the menu and also start a new
  "" line.
  "inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

  " If there's a ~/.config/dotfiles/.vimrc_plugins use that one
  if filereadable(expand("~/.config/dotfiles/.vimrc_plugins"))
    source ~/.config/dotfiles/.vimrc_plugins
  endif

  " Add support for cue files
  Plug 'jjo/vim-cue'

  call plug#end()
endif

" Finish setting up colors to match shell
if filereadable(expand("~/.vimrc_background"))
  set termguicolors
  let base16colorspace=256
  source ~/.vimrc_background
endif

"" ycm ---------------------------
"" don't display the silly preview window when completing
" let g:ycm_add_preview_to_completeopt = 0
" set completeopt-=preview
" "" recommended by syntastic I think
" let g:ycm_show_diagnostics_ui = 1
" "" maybe speed things up?
" let g:ycm_cache_omnifunc = 1
" "" display suggestions right away
" let g:ycm_min_num_of_chars_for_completion = 1
" "" disable python2
" let g:loaded_python_provider = 0
" let g:ycm_server_python_interpreter = "/usr/bin/python3"
"



"" workaround for tab conflict; see also
"" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme#22253548
"" for other ideas
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<down>"
let g:UltiSnipsJumpBackwardTrigger="<up>"
let g:UltiSnipsEditSplit="vertical"



" Share clipboard copy buffer with host
"noremap <Leader>y "*y
"noremap <Leader>p "*p
"noremap <Leader>Y "+y
"noremap <Leader>P "+p
" Share copy buffer with host via osc 52 and the host when using tmux
noremap <Leader>y :call SendViaOSC52(getreg('"'))<cr>:call system('~/dotfiles/util/yank.sh', @")<cr>

" Enable syntax highlighting
syntax enable

" Set color scheme
try
  colorscheme monokai
catch /^Vim(colorscheme):/
endtry

" Open nerdtree when no files were selected on startup
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
" Close nerdtree if nothing else is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Support unicode
scriptencoding utf-8
set encoding=utf-8

" Slower scrolling
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Don't leave the cursor at the edge
set scrolloff=5


nnoremap <F2> :NERDTreeToggle<CR>
set lazyredraw
nnoremap <Leader>n :NERDTreeFind<CR>

"set t_ti=
"set t_ks=
"set t_te=
"set t_ke=


" tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" search selected string in the project
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" helm tpl files
autocmd BufNewFile,BufRead *.tpl set syntax=yaml

" TODO: check out https://github.com/Quramy/vison
" https://github.com/neoclide/coc-yaml
" http://schemastore.org/json/
"

" If there's a ~/.config/dotfiles/.vimrc use that one
if filereadable(expand("~/.config/dotfiles/.vimrc"))
  source ~/.config/dotfiles/.vimrc
endif

autocmd BufWritePre * %s/\s\+$//e
