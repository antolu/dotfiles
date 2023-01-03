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
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_nvim_statusline = 0 " disable statusline overwriting

    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
    nnoremap <silent> <leader>A :Windows<CR>
    nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
    nnoremap <silent> <leader>. :AgIn

    nnoremap <silent> K :call SearchWordWithAg()<CR>
    vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>
    nnoremap <silent> <leader>ft :Filetypes<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    function! SearchWordWithAg()
        execute 'Ag' expand('<cword>')
    endfunction

    function! SearchVisualSelectionWithAg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Ag' selection
    endfunction

    function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
    endfunction
    command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

    " ==============================================
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

