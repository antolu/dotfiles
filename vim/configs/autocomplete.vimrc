" Autocomplete
" {{{
    Plug 'github/copilot.vim'

    imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    imap <silent> <C-\> <Plug>(copilot-suggest)
    imap <silent> <C-'> <Plug>(copilot-dismiss)
    imap <silent> <C-]> <Plug>(copilot-next)
    " imap <silent> <C-[> <Plug>(copilot-previous)

    let g:copilot_no_tab_map = v:true
" }}}

