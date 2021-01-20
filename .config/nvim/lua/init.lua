require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

local lspconfig = require('lspconfig')

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require('completion').on_attach(client)
end

-- lspconfig.hls.setup({ on_attach=on_attach })
lspconfig.sumneko_lua.setup({
    cmd = {'/usr/bin/lua-language-server'},
    on_attach=on_attach
})
lspconfig.rust_analyzer.setup({ on_attach=on_attach })
