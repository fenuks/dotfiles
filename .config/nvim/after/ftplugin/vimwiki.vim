if exists('b:did_wiki_ftplugin') | finish | endif
let b:did_wiki_ftplugin = 1

call ConfigureLanguage()
nmap <buffer> gf <Plug>VimwikiFollowLink
nmap <buffer><silent> ]u <Plug>VimwikiNextLink
nmap <buffer><silent> [u <Plug>VimwikiPrevLink
