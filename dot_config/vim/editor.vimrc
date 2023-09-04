" Text objects
" {
    Plug 'vim-scripts/argtextobj.vim'
    Plug 'michaeljsmith/vim-indent-object'

    Plug 'kana/vim-textobj-user'
    Plug 'bps/vim-textobj-python'
"}


" Syntax highlighting
" {{{
if !has('nvim')
    Plug 'scrooloose/syntastic'

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    Plug 'dense-analysis/ale'
endif
" }}}

if !has('nvim')
" Easymotion
" {
    Plug 'easymotion/vim-easymotion'

    nnoremap <leader><leader>w <Plug>(easymotion-bd-w)
    nnoremap <leader><leader>t <Plug>(easymotion-bd-t)
    nnoremap <leader><leader>f <Plug>(easymotion-bd-f)
    nnoremap <leader><leader>F <Plug>(easymotion-overwin-f)
    nnoremap <leader><leader>e <Plug>(easymotion-bd-e)
    nnoremap <leader><leader>L <Plug>(easymotion-overwin-line)
    nnoremap <leader><leader>W <Plug>(easymotion-overwin-w)
    nnoremap <leader><leader>s <Plug>(easymotion-s2)
    nnoremap <leader><leader>S <Plug>(easymotion-overwin-f2)

    nnoremap <leader><leader>r <Plug>(easymotion-repeat)
    nnoremap <leader><leader>n <Plug>(easymotion-next)
    nnoremap <leader><leader>p <Plug>(easymotion-prev)
" }
endif

" Movement and quick edits
" {{{
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'matze/vim-move'
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-commentary'
" }}}

" Markdown
" {{{
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'

    let g:vim_markdown_new_list_item_indent = 0
" }}}

" Spelling
" {{{
    Plug 'preservim/vim-lexical'

    augroup lexical
        autocmd!
        autocmd FileType markdown,mkd call lexical#init()
        autocmd FileType textile call lexical#init()
        autocmd FileType text call lexical#init({ 'spell': 0 })
    augroup END

    let g:lexical#spell = 1         " 0=disabled, 1=enabled
" }}}


" Whitespace
set wrap
set textwidth=0
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set list                       " show trailing whitespace
"
" Visualize tabs and newlines
set listchars=tab:▸\ ,trail:▫,eol:¬
map <leader>i :set list!<CR> " Toggle tabs and EOL

set autoindent
set autoread

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX') && has('vim')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Formatting
map <leader>q gqip

