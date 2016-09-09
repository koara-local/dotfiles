" Plugin key-mappings.
imap <Nul> <C-Space>
smap <Nul> <C-Space>
xmap <Nul> <C-Space>
imap <Nul> <Plug>(neosnippet_expand_or_jump)
smap <Nul> <Plug>(neosnippet_expand_or_jump)
xmap <Nul> <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
