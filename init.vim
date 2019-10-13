" ===============
" Plugins
" ===============
" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" ====================
" Auto comments
" ====================
Plug 'tpope/vim-commentary'

" ====================
" Auto-close brackets
" ====================
Plug 'jiangmiao/auto-pairs'

" ====================
" Autocomplete plugins
" ====================
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion sources
" ==================
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tern', { 'do': 'yarn install' }
Plug 'ncm2/ncm2-jedi', { 'on': ['python'] }

" ALE Linter
" ==========
Plug 'w0rp/ale'

" Javascript support
" ==================
Plug 'pangloss/vim-javascript', { 'on': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'on': ['javascript', 'javascript.jsx'] }

" Java support
" ===============
Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}

" C/C++ support
" =============
Plug 'ncm2/ncm2-pyclang', { 'on': ['c', 'cpp'] }
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-8/lib'

" Latex
" ==================
Plug 'lervag/vimtex', { 'on': ['tex'] }
Plug 'matze/vim-tex-fold', { 'on': ['tex'] }
let g:tex_flavor = 'latex'
let g:text_conceal = ''
let g:fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'

" Markdown
" ==================
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Colorscheme
" ================
Plug 'trevordmiller/nova-vim'
Plug 'morhetz/gruvbox'

call plug#end()

" =============
" NCM2 Settings
" =============
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" required settings
set completeopt=noinsert,menuone,noselect
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() && empty(v:completed_item) ? "\<c-y>\<cr>" : "\<CR>")

" faster autocompletion
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
" enable fuzzy matcher
let g:ncm2#matcher = 'substrfuzzy'
augroup NCM2
	autocmd!
	" uncomment this block if you use vimtex for LaTex
	autocmd Filetype tex call ncm2#register_source({
				\ 'name': 'vimtex',
				\ 'priority': 8,
				\ 'scope': ['tex'],
				\ 'mark': 'tex',
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
augroup END

" ================
" ALE Settings
" ================
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = '>>'
let g:ale_echo_msg_warning_str = '-'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" ====================
" Jedi Settings
" ====================
" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" ======
" Colors
" ======
colorscheme gruvbox 
set background=dark

" =======================
" General Editor Settings
" =======================
" Numbers on the sidebar
set number
set relativenumber

" filename up top
set title

" padding at the bottom
set scrolloff=10

" Search configuration
set ignorecase
set smartcase

set termguicolors
set lazyredraw
" Syntax help
syntax on
filetype indent on
filetype plugin on

" Smarter cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Consistent search direction
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Esc to escape from terminal
:tnoremap <Esc> <C-\><C-n>

" Search continue from top
set wrapscan

" Open new split on the right and bottom
set splitbelow 
set splitright

" Save to buffer automatically
" autocmd TextChanged,TextChangedI <buffer> write
