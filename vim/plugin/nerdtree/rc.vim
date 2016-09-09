augroup my_nerdtree_settings
    autocmd!
    " key mappings
    nmap <silent> <Space>F :<C-u>NERDTreeToggle<CR>
    " auto close when last buffer is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&
            \ b:NERDTreeType == "primary") | q | endif
augroup END
