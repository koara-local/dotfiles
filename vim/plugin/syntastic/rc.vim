let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" なぜかQuickfix listのエラーがでるので必ず0にする
let g:syntastic_auto_loc_list = 0

let g:syntastic_enable_signs   = 1
let g:syntastic_error_symbol   = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_echo_current_error  = 1
let g:syntastic_enable_highlighting = 0

let g:syntastic_c_config_file   = '~/.clang_complete'
let g:syntastic_cpp_config_file = '~/.clang_complete'
let g:syntastic_cpp_compiler_options = '-std=c++1y -Wall -Weffc++'
let g:syntastic_c_compiler = 'clang++'

" cpplint
let g:syntastic_cpp_cpplint_thres = 5
let g:syntastic_cpp_cpplint_args = '--verbose=3'

nnoremap <silent> <Space>s :<C-u>SyntasticCheck cpplint<CR>
