" Syntax highlighting
" {{{
    Plug 'scrooloose/syntastic'

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    Plug 'dense-analysis/ale'
" }}}

" Movement and quick edits
" {{{
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'easymotion/vim-easymotion'
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-commentary'

    Plug 'ludovicchabant/vim-gutentags'
    
    let g:gutentags_ctags_tagfile = '.tags'
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

" Python
" {{{
    Plug 'puremourning/vimspector'
    nnoremap <F5> :call vimspector#Launch()<CR>
    nnoremap <Leader>de :call vimspector#Reset()<CR>
    nnoremap <Leader>dc :call vimspector#Continue()<CR>

    nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
    nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

    nmap <Leader>dr <Plug>VimspectorRestart
    nmap <F9> <Plug>VimspectorStepOut
    nmap <F7> <Plug>VimspectorStepInto
    nmap <F8> <Plug>VimspectorStepOver

    let g:vimspector_enable_mappings = 'HUMAN'

    Plug 'kana/vim-textobj-user'
    Plug 'bps/vim-textobj-python'
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

    let g:pymode_lint_cwindow=0
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
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Formatting
map <leader>q gqip

