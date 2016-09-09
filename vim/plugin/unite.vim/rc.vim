let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 50
let g:unite_split_rule = 'botright'
nnoremap <silent> <Space>y :<C-u>Unite history/yank<CR>
nnoremap <silent> <Space>b :<C-u>Unite buffer:-<CR>
nnoremap <silent> <Space>t :<C-u>Unite tab<CR>
nnoremap <silent> <Space>f :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> <Space>g :<C-u>Unite file_rec/git<CR>
nnoremap <silent> <Space>r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>i :<C-u>Unite file_include<CR>
nnoremap <silent> <Space>l :<C-u>Unite line<CR>
nnoremap <silent> <Space>G :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <Space>[ :<C-u>UnitePrevious<CR>
nnoremap <silent> <Space>] :<C-u>UniteNext<CR>
nnoremap <silent> <Space><Space> :<C-u>UniteResume<CR>

" unite grepにhw(highway)を使う
if executable('hw')
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color -e'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <silent> <Space>u :<C-u>Unite file_mru buffer:-<CR>
