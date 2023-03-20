if !has('nvim')
" Airline bar
" {{{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
" }}}
endif

" Tagbar
"{{{
    Plug 'majutsushi/tagbar'
    nmap <leader>tb :TagbarOpen [fj]<CR>
    nmap <leader>tc :TagbarClose<CR>
    nmap <leader>tp :TagbarPauseToggle<CR>
" }}}

" UI Plugins
" {{{
    Plug 'ryanoasis/vim-devicons'
" }}}

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Rendering
set ttyfast

" Resize shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

