command! -nargs=* Agp
\ call fzf#vim#ag(<q-args>, '2> /dev/null',
\                 fzf#vim#with_preview({'left':'90%'},'up:60%'))

imap <silent> <unique> <c-x><c-f> <Plug>(fzf-complete-path)
imap <silent> <unique> <c-x>f <Plug>(fzf-complete-path)

imap <silent> <unique> <c-x><c-l> <Plug>(fzf-complete-buffer-line)
imap <silent> <unique> <c-x>l <Plug>(fzf-complete-buffer-line)
