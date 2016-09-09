let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1
let g:gitgutter_max_signs = 2000
let g:gitgutter_escape_grep = 1
let g:gitgutter_highlight_lines = 0

nnoremap <silent> [h :<C-u>GitGutterPrevHunk<CR>
nnoremap <silent> ]h :<C-u>GitGutterNextHunk<CR>
nnoremap <silent> gA :<C-u>GitGutterStageHunk<CR>
