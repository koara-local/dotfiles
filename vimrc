" ----------------------------------------------------------------------------------------
".vimrc
" ----------------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------------

" syntax hilight
syntax enable

" scriptencoding
scriptencoding utf-8
set encoding=utf-8

" 2バイト半角文字の設定
set ambiwidth=double

" タブと行末スペースを可視化
set list
set listchars=tab:^\ ,trail:~

"スペルチェックを有効にする(ただし日本語は除外する)
"set spelllang+=cjk
"set spell

" number
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" TAB
"set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" INDENT
set autoindent
set smartindent

" BACKSPACE
set backspace=indent,eol,start

" SCROLL
set scrolloff=5
set lazyredraw

" 更新時自動再読込み
set autoread
" 編集中でも他のファイルを開けるようにする
set hidden
" スワップファイルを作らない
set noswapfile

" SEARCH
set incsearch
set hlsearch

" CURSOR LINE
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" Status Line
set laststatus=2

" Space prefix
nnoremap [space] <Nop>
nmap     <Space> [space]
xmap     <Space> [space]

" KEYMAP
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <silent> [space]p :bprevious<CR>
nnoremap <silent> [space]n :bnext<CR>

nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" Edit vimrc
nmap ,v :edit $MYVIMRC<CR>
"nmap [space]g :edit $MYGVIMRC<CR>

" 横幅と縦幅を見て縦分割か横分割か決める
" http://qiita.com/Linda_pp/items/392be95a195067d84fd8
command! -nargs=? -complete=command SmartSplit call <SID>smart_split(<q-args>)
function! s:smart_split(cmd)
    if winwidth(0) > winheight(0) * 2
        vsplit
    else
        split
    endif

    if !empty(a:cmd)
        execute a:cmd
    endif
endfunction
nnoremap <silent><C-w><Space> :<C-u>SmartSplit<CR>

" Ctrl + j, k, h, lでウインドウを移動できるように
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" CLIP BOARD
set clipboard=unnamed,autoselect

" set paste
nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>

" command mode
set wildmenu
set wildmode=longest:full,full

" Vimを終了してもUndo
if has('persistent_undo')
  set undofile
  set undodir=./.vimundo,~/.vim/undo
endif

" :vimgrepでの検索後QuickFixウインドウを自動的に開く
augroup grepopen
  autocmd!
  autocmd QuickfixCmdPost vimgrep cw
augroup END

" ファイルを開いた時にカーソルを前回編集時の位置に移動
augroup previousline
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Strip trailing whitespace
" http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"augroup trailingwhitespace
"  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
"augroup END

" ----------------------------------------------------------------------------------------
"   neobundle
" ----------------------------------------------------------------------------------------
set nocompatible               " Be iMproved

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
        \ 'windows' : 'make -f make_mingw32.mak',
        \ 'cygwin'  : 'make -f make_cygwin.mak ',
        \ 'mac'     : 'make -f make_mac.mak    ',
        \ 'unix'    : 'make -f make_unix.mak   ',
    \ },
\ }

filetype plugin indent on     " Required!

" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Bundle
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
else
    NeoBundle 'Shougo/neocomplcache.vim'
endif

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundleLazy 'Shougo/vimshell.vim', {
    \ 'depends' : [ 'Shougo/vimproc.vim' ]
    \ }
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'sakuraiyuta/commentout.vim'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'rhysd/clever-f.vim'

NeoBundleLazy 'Rip-Rip/clang_complete', {
    \ 'autoload' : {
    \     'filetypes' : ['c', 'cpp'],
    \    },
    \ }

NeoBundle 'scrooloose/syntastic'


" NeoBundle Setup
" ----------------------------------------------------------------------------------------
"    'Shougo/neocomplete.vim'
" ----------------------------------------------------------------------------------------
"    'Shougo/neocomplcashe'
" ----------------------------------------------------------------------------------------
if s:meet_neocomplete_requirements()
    " ------------------------------------------------------------------------------------
    " neocomplete の設定
    " ------------------------------------------------------------------------------------
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    " For clang_complete
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_overwrite_completefunc = 1

    let g:neocomplete#force_omni_input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.objc =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.objcpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
else
    " ------------------------------------------------------------------------------------
    " neocomplcache の設定
    " ------------------------------------------------------------------------------------
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Enable heavy features.
    " Use camel case completion.
    "let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    "let g:neocomplcache_enable_underbar_completion = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    let g:neocomplcache_force_overwrite_completefunc=1

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

" ----------------------------------------------------------------------------------------
"    'Shougo/neosnippet'
" ----------------------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ----------------------------------------------------------------------------------------
"    'Shougo/unite.vim'
" ----------------------------------------------------------------------------------------
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> [space]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [space]b :<C-u>Unite buffer<CR>
nnoremap <silent> [space]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [space]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [space]u :<C-u>Unite file_mru buffer<CR>

" ----------------------------------------------------------------------------------------
"    'Shougo/unite-outline'
" ----------------------------------------------------------------------------------------
let g:unite_split_rule = 'botright'
noremap [space]o <ESC>:Unite -vertical -winwidth=60 outline<Return>

" ----------------------------------------------------------------------------------------
"    'sakuraiyuta/commentout.vim'
" ----------------------------------------------------------------------------------------


" ----------------------------------------------------------------------------------------
"    'airblade/vim-gitgutter'
" ----------------------------------------------------------------------------------------
highlight clear SignColumn " override default colorscheme
let g:gitgutter_sign_column_always = 1

" ----------------------------------------------------------------------------------------
"    'itchyny/lightline.vim'
" ----------------------------------------------------------------------------------------
" vim-gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '-'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1

" lightline.vim
let g:lightline = {
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['fugitive', 'gitgutter', 'filename'],
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'gitgutter': 'MyGitGutter',
        \ },
        \ 'separator': {'left': '|', 'right': '|'},
        \ 'subseparator': {'left': '|', 'right': '|'}
        \ }

function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "RO"
    else
        return ""
    endif
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" ----------------------------------------------------------------------------------------
"    'Rip-Rip/clang_complete'
" ----------------------------------------------------------------------------------------
set completeopt=menuone
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_complete_copen = 0
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib/llvm'
let g:clang_debug = 0
let g:clang_user_options = '-std= c++11'

" ----------------------------------------------------------------------------------------
"    'scrooloose/syntastic'
" ----------------------------------------------------------------------------------------

let g:syntastic_check_on_open = 1

let g:syntastic_enable_signs   = 1
let g:syntastic_error_symbol   = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_echo_current_error  = 1
let g:syntastic_auto_loc_list       = 2
let g:syntastic_enable_highlighting = 0

let g:syntastic_c_config_file   = '~/.clang_complete'
let g:syntastic_cpp_config_file = '~/.clang_complete'

" cpplint
let g:syntastic_cpp_cpplint_thres = 5
let g:syntastic_cpp_cpplint_args = '--verbose=3'

" ----------------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------------
" Installation check.
NeoBundleCheck

