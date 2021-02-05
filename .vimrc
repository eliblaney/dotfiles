" Toggle onedark theme
let using_onedark = 1

set nocompatible
filetype plugin on
set tags=tags;/
"let g:easytags_dyanmic_files = 1

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugin
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Appearance
if using_onedark
	Plugin 'joshdick/onedark.vim'
endif
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Editing
if executable('ctags') && v:version >= 800
	Plugin 'ludovicchabant/vim-gutentags'
	Plugin 'skywind3000/gutentags_plus'
endif
Plugin 'preservim/nerdcommenter'
Plugin 'AndrewRadev/splitjoin.vim'
if has('python') || has('python3')
	Plugin 'Valloric/MatchTagAlways'
endif
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
"Autocompletion
Plugin 'vim-scripts/surround.vim'
Plugin 'mattn/emmet-vim'
Plugin 'ajh17/VimCompletesMe'
"Plugin 'ycm-core/YouCompleteMe'
Plugin 'Shougo/neopairs.vim'
Plugin 'shougo/context_filetype.vim'
" File system (^f)
if executable('fzf')
	Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plugin 'junegunn/fzf.vim'
endif
Plugin 'preservim/nerdtree'
" Shell (^s)
if v:version >= 800
	Plugin 'Shougo/deol.nvim'
endif
" Git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'airblade/vim-gitgutter'
" Linting (^l)
Plugin 'dense-analysis/ale'
" Languages
Plugin 'sheerun/vim-polyglot'
Plugin 'rust-lang/rust.vim'
Plugin 'xsbeats/vim-blade'
Plugin 'ap/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
" Debugging
if has('python3')
	Plugin 'puremourning/vimspector'
endif
" Util
Plugin 'editorconfig/editorconfig-vim'
Plugin 'szw/vim-maximizer'

call vundle#end()
filetype plugin indent on

let mapleader=","

let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"

" disable help menu
map <F1> <Nop>

" lines of history
set history=700

" enable (hybrid) line numbers
set number
set relativenumber

" auto update when edited from outside source
set autoread

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" performance boost
set lazyredraw

" regex
set magic

" matching brackets
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2

" disable error noises
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" syntax highlighting
syntax enable

colorscheme desert
set background=dark

" gui options
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8

" unix as the standard file type
set ffs=unix,dos,mac

set ai " auto indent
set si " smart indent

" treat long lines as break lines
map j gj
map k gk

" always show the status line
set laststatus=2

" format status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ Line:\ %l

" remap VIM 0 to first non-blank character
nmap <C-0> 0
map 0 ^

" moving lines around using ALT+[jk] (or Command+[jk] on mac)
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'.+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" delete trailing whitespace on save for Python/CoffeeScript
"function DeleteTrailingsWS()
"    exe "normal mz"
"    %s/\s\+$//ge
"    exe "normal `z"
"endfunction
"autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Pressing ,ss will toggle spell checking
map <leader>ss :setlocal spell!<cr>

" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" show current position
set ruler

" command bar
set cmdheight=2

" match brackets
set showmatch
set matchtime=3

" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction

" soft wrap text
set wrap linebreak nolist
" do not indicate line breaks with a special character
set showbreak=

" tabs
set tabstop=4
set shiftwidth=4

set smarttab
set smartindent
set autoindent

augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

""" ENABLE ONEDARK.VIM COLOR SCHEME

if using_onedark
	let g:onedark_terminal_italics=1
endif
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
if (has("nvim"))
	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
	set termguicolors
endif
"endif
syntax on
if using_onedark
	colorscheme onedark
endif

" Airline config

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''

" ALE Configuration (auto-syntax-check / auto-linting)
let g:ale_linters = {
			\   'python': ['flake8', 'pylint'],
			\   'javascript': ['eslint'],
			\   'php': ['phpcbf'],
			\}
let g:ale_fixers = {
			\   'python': [
			\		'remove_trailing_lines',
			\		'trim_whitespace',
			\		'reorder-python-imports',
			\		'yapf',
			\	],
			\   'javascript': [
			\		'remove_trailing_lines',
			\		'trim_whitespace',
			\       'eslint',
			\   ],
			\   'php': [
			\		'remove_trailing_lines',
			\		'trim_whitespace',
			\       'php_cs_fixer',
			\       'phpcbf',
			\   ],
			\}
let g:ale_fix_on_save = 1

" Force true colors
if v:version > 740
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

" Highlight line in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Cursor settings
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
" Optionally reset the cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Autocomplete settings
let g:jedi#show_call_signatures = "1"
autocmd FileType python setlocal completeopt-=preview

" Debugging mappings
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GoToWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GoToWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GoToWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GoToWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GoToWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dr <Plug>VimspectorRestart
nmap <leader>dn :call vimspector#Continue()<CR>
nmap <leader>dt <Plug>VimspectorRunToCursor
nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dv <Plug>VimspectorToggleConditionalBreakpoint
let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools', 'CodeLLDB']

" Run code
augroup runbinds
	autocmd! runbinds
	autocmd FileType python map <C-h> <Esc>:w<CR>:!clear;python3 %<CR>
	autocmd FileType rust map <C-h> :execute "!clear;cargo run"<CR>
augroup end

" Git mappings
nmap <leader>gm :GMove
nmap <leader>gn :GRename
nmap <leader>gr :GDelete
nmap <leader>gd :GDiffsplit
nmap <leader>gb :GBrowse
nmap <leader>gl :Git blame

" Mappings
map <C-l> :ALEFix<CR>
map <C-f> :Files<CR>
map <C-g> :GFiles<CR>
map <C-s> :Deol<CR>
map <C-t> :NERDTreeToggle<CR>
map <C-c> :NERDCommenterComment<CR>
map <C-m> :MaximizerToggle!<CR>
