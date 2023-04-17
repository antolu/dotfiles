set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | Alpha | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'cd '.argv()[0] | Alpha | endif

" {{{
    Plug 'goolord/alpha-nvim'
    Plug 'edluffy/specs.nvim'
    Plug 'petertriho/nvim-scrollbar'
    Plug 'kevinhwang91/nvim-hlslens'
    Plug 'yorickpeterse/nvim-window'
    " Plug 'romgrk/barbar.nvim'

    Plug 'rmagatti/auto-session'
    Plug 'rmagatti/session-lens'
" }}}

" Tags
" {{{
    " Plug 'ludovicchabant/vim-gutentags'
    " Plug 'skywind3000/gutentags_plus'
    
    " let g:gutentags_ctags_tagfile = '.tags'
    " let g:gutentags_modules = ['ctags', 'gtags_cscope']
    " let g:gutentags_project_root = ['.use_tags']
    " let g:gutentags_cache_dir = expand('~/.cache/tags')
" }}}

" Python debugging
" {{{
    " Plug 'puremourning/vimspector'
    " nnoremap <F5> :call vimspector#Launch()<CR>
    " nnoremap <Leader>de :call vimspector#Reset()<CR>
    " nnoremap <Leader>dc :call vimspector#Continue()<CR>

    " nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
    " nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

    " nmap <Leader>dr <Plug>VimspectorRestart
    " nmap <F9> <Plug>VimspectorStepOut
    " nmap <F7> <Plug>VimspectorStepInto
    " nmap <F8> <Plug>VimspectorStepOver

    " let g:vimspector_enable_mappings = 'HUMAN'

    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

    " let g:pymode_lint_cwindow=0
" }}}

" nvim tree
" {{{
    " Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-neo-tree/neo-tree.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
" }}}

" fzf
" {{{

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_nvim_statusline = 0 " disable statusline overwriting

    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>ft :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    " nnoremap <silent> <leader>fh :Helptags<CR>
" }}}

" lualine
" {{{
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'SmiteshP/nvim-navic'
" }}}

" telescope.nvim
" {{{
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'folke/which-key.nvim'
" }}}

" treesitter
" {{{
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'folke/trouble.nvim'
    Plug 'ziontee113/syntax-tree-surfer'
    Plug 'stevearc/aerial.nvim'
" }}}

" gitsigns.nvim
" {{{
    Plug 'lewis6991/gitsigns.nvim'
" }}}

" leap.nvim
" {{{
    Plug 'ggandor/leap.nvim'
" }}}

" hop.nvim
" {{{
    Plug 'phaazon/hop.nvim'
" }}}

" LSP
" {{{
    Plug 'williamboman/mason.nvim'
    Plug 'lukas-reineke/lsp-format.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
" }}}

" Completion
" {{{
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'onsails/lspkind.nvim'

    Plug 'windwp/nvim-autopairs'
    Plug 'ThePrimeagen/refactoring.nvim'
    
    Plug 'zbirenbaum/copilot.lua'
    Plug 'zbirenbaum/copilot-cmp'
    Plug 'weilbith/nvim-code-action-menu'

    Plug 'kosayoda/nvim-lightbulb'
    Plug 'antoinemadec/FixCursorHold.nvim'
" }}}

" theme
" {{{
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'navarasu/onedark.nvim'
" }}}

call plug#end()

" Theme
" {{{
    " "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
    "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
    if (empty($TMUX))
      if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      endif
      "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
      "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
      " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
      if (has("termguicolors"))
        set termguicolors
      endif
    endif
" }}}
colorscheme onedark

lua require("vim.lsp.log").set_format_func(vim.inspect)

lua require('leap').add_default_mappings()
lua require('mason').setup()
lua require('mason-lspconfig').setup({automatic_installation = true,})
lua require('nvim-lightbulb').setup({autocmd = {enable = true}})
lua require('which-key').setup({disable = {buftypes = {'cmdline'}}})

lua require('plugins.configs.aerial').setup()
lua require('plugins.configs.alpha').setup()
" lua require('plugins.configs.barbar').setup()
lua require('plugins.configs.copilot').setup()
lua require('plugins.configs.diagnostic').setup()
lua require('plugins.configs.gitsigns').setup()
lua require('plugins.configs.hop').setup()
lua require('plugins.configs.lsp-format').setup()
lua require('plugins.configs.lsp').setup()
lua require('plugins.configs.lualine').setup()
lua require('plugins.configs.luasnip').setup()
lua require('plugins.configs.null-ls').setup()
lua require('plugins.configs.nvim-autopairs').setup()
lua require('plugins.configs.nvim-cmp').setup()
" lua require('plugins.configs.nvim-tree').setup()
lua require('plugins.configs.neo-tree').setup()
lua require('plugins.configs.nvim-treesitter-textobjects').setup()
lua require('plugins.configs.nvim-treesitter').setup()
lua require('plugins.configs.nvim-window').setup()
lua require('plugins.configs.refactoring').setup()
lua require('plugins.configs.scrollbar').setup()
lua require('plugins.configs.session').setup()
lua require('plugins.configs.specs').setup()
lua require('plugins.configs.syntax-tree-surfer').setup()
lua require('plugins.configs.telescope').setup()
lua require('plugins.configs.trouble').setup()
