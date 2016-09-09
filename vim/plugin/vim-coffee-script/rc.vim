" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" インデントを設定
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
