set number
set lazyredraw
set autoindent
set tabstop=4
set softtabstop=4
set expandtab
set showcmd
set incsearch
set shiftwidth=4
set smarttab
set autoread
set laststatus=2
set linebreak
set completeopt=longest,menuone
filetype indent on
filetype plugin on

" Spell checker
" Run with :WP
func! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu

com! WP call WordProcessorMode()
autocmd FocusGained,CursorHold,BufEnter ?* if getcmdwintype() == '' | checktime | endif

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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

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

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Ruby support
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
" Rails support
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }

" Javascript and JSX support
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }

" Nova colorscheme
Plug 'trevordmiller/nova-vim'

call plug#end()

let g:lightline = {
            \'colorscheme': 'wombat',
            \'active' : {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'helloworld' ] ]
            \ },
            \ 'component': {
            \   'helloworld': 'Stay awesome!',
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ }
            \ }

let g:deoplete#enable_at_startup = 1

let g:nova_transparent = 1

" -------------
" Mappings
" -------------
"  set new mapleader
map <SPACE> <leader>
" start nerdtree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Ctrl-P to activate fuzzy finder
map <C-p> :Files<CR> 
" Ctrl-` to open up terminal
map <leader>t :botright terminal<CR> 

" tab and shift-tab to cycle suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

colorscheme nova 
