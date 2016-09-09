" git
au BufNewFile,BufRead .gitconfig.* setf gitconfig
" vim
au BufNewFile,BufRead .vimrc.* setf vim
" markdown (overwrite : Default *.md is modula2)
au BufNewFile,BufRead *.md :set filetype=markdown
" toml
au BufNewFile,BufRead *.toml :set filetype=toml
" jade
au BufNewFile,BufRead *.jade :set filetype=jade
" waf
au BufNewFile,BufRead wscript :set filetype=python

