" ref: http://qiita.com/msmhrt/items/486658cd251302e2edf6
let s:saved_t_Co=&t_Co

augroup restore_t_Co
  autocmd!
  autocmd VimLeave * let &t_Co = s:saved_t_Co == 8 ? 256 : 8
  autocmd VimLeave * let &t_Co = s:saved_t_Co
augroup END

let mapleader = "\<Space>"

set runtimepath+=~/.vim
runtime! userautoload/*.vim
