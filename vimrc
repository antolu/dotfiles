if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source ~/.vim/configs/preamble.vimrc

call plug#begin('~/.vim')

source ~/.vim/configs/editor.vimrc

source ~/.vim/configs/autocomplete.vimrc

source ~/.vim/configs/latex.vimrc

source ~/.vim/configs/workspace.vimrc

source ~/.vim/configs/interface.vimrc

call plug#end()

source ~/.vim/configs/postamble.vimrc

