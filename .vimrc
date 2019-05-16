set number
set lazyredraw
set autoindent
set tabstop=4
set softtabstop=4
set expandtab
filetype indent on
set showcmd
set incsearch
set shiftwidth=4
set smarttab
set autoread
set laststatus=2
:colorscheme iceberg
" Spell checker
" Run with :WP
func! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu

com! WP call WordProcessorMode()
autocmd FocusGained,CursorHold ?* if getcmdwintype() == '' | checktime | endif

" install vimplug automagically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')
" Lightline statusline
Plug 'itchyny/lightline.vim'

" NERDTree
Plug 'scrooloose/nerdtree'

" Ctrl P in Vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Autoclose brackets
Plug 'cohama/lexima.vim'

" Ruby support
Plug 'vim-ruby/vim-ruby'
" Rails support
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }

call plug#end()

let g:lightline = {'colorscheme': 'wombat'}
let g:deoplete#enable_at_startup = 1
" Mappings
" start nerdtree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" tab and shift-tab to cycle suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "<C-g>u\<CR>"
" Ctrl-P to activate fuzzy finder
map <C-p> :Files<CR> 
