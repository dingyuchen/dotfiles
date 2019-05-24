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
set completeopt=noinsert,menuone,noselect
filetype indent on
filetype plugin on
set wildmenu
set wildmode=longest:full,full
set ignorecase
set smartcase
set title
set scrolloff=5
set hidden

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
autocmd BufEnter * call ncm2#enable_for_buffer()

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

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Completion sources
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Linting
Plug 'w0rp/ale'

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
Plug 'ncm2/ncm2-tern', { 'do': 'yarn install' }

" Nova colorscheme
Plug 'trevordmiller/nova-vim'

call plug#end()

let g:lightline = {
            \'colorscheme': 'nova',
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
map , <leader>
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

" shortcut to exit terminal
tnoremap <C-[> <C-\><C-n>

" Ctrl-w twice to save
nnoremap <C-w><C-w> :w<CR>

colorscheme nova 
