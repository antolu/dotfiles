" Git
" {{{
    Plug 'tpope/vim-fugitive'
" }}}

" NerdTree
" {{{
    Plug 'preservim/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeHijackNetrw = 0
    let g:NERDTreeWinSize = 31
    let g:NERDTreeChDirMode = 2
    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeCascadeOpenSingleChildDir = 1

    map <F1> :call NERDTreeToggleAndFind()<cr>
    map <F2> :NERDTreeToggle<CR>

    function! NERDTreeToggleAndFind()
        if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
          execute ':NERDTreeClose'
        else
          execute ':NERDTreeFind'
        endif
    endfunction
" }}}

" Workspace
" {{{
    Plug 'tpope/vim-obsession'
    let g:workspace_session_directory = $HOME . '/.vim/sessions/'
" }}}

" Fuzzy file search
" {{{
    Plug 'ctrlpvim/ctrlp.vim'

    let g:ctrlp_map = '<c-p>'

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

    let g:ctrlp_user_command = 'find %s -type f'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" }}}

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader>cs :let @/=''<cr> " clear search

" WakaTime
" {{{
    Plug 'wakatime/vim-wakatime'
" }}}
