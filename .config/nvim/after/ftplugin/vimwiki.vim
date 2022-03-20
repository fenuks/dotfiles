if exists('b:did_wiki_ftplugin') | finish | endif
let b:did_wiki_ftplugin = 1

setlocal foldlevel=0
setlocal foldclose=all
setlocal textwidth=80
call ConfigureLanguage()
nmap <buffer> <silent> gf <Plug>VimwikiFollowLink
nmap <buffer> <silent> <C-w><C-f> <Plug>VimwikiVSplitLink
nmap <buffer> <silent> <C-w>gf <Plug>VimwikiTabnewLink

" nmap <buffer> <silent> <Plug>VimwikiAddHeaderLevel
" nmap <buffer> <silent> <Plug>VimwikiRemoveHeaderLevel
" nmap <buffer> <silent> <Plug>VimwikiGoToParentHeader

" <alt+j>
imap <buffer> <silent> ə <Plug>VimwikiTableNextCell
" <alt+k>
imap <buffer> <silent> … <Plug>VimwikiTablePrevCell
