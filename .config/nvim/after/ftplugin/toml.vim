if exists('b:did_toml_ftplugin') | finish | endif
let b:did_toml_ftplugin = 1

if expand('%:t') ==# 'Cargo.toml'
    compiler cargo
endif
