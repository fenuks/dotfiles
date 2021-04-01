require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "„", -- <a-v>
      node_incremental = "„",
      node_decremental = "‘",  --- <a-s-v>
      scope_incremental = "ss",
    },
  },
  indent = {
    enable = false
  }
}

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local lspconfig = require('lspconfig')
local completion = require('completion')

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    vim.call("deoplete#custom#buffer_option", 'auto_complete', false)
    completion.on_attach(client)

    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]

    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','<c-]>','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','<c-k>','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','si','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','g0','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','sa','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','se','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>rn','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

lspconfig.hls.setup({ on_attach=on_attach })
if vim.fn.executable('clangd') then
  lspconfig.clangd.setup({ on_attach=on_attach })
elseif vim.fn.executable('ccls') then
  lspconfig.ccls.setup({ on_attach=on_attach })
end
lspconfig.tsserver.setup({ on_attach=on_attach })
lspconfig.sumneko_lua.setup({
    cmd = {'/usr/bin/lua-language-server'},
    on_attach=on_attach
})
lspconfig.rust_analyzer.setup({ on_attach=on_attach })
