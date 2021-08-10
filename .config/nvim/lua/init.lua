require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '„', -- <a-v>
      node_incremental = '„',
      node_decremental = '‘', --- <a-s-v>
      scope_incremental = 'sv',
    },
  },
  indent = {
    enable = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
    -- smart_rename = {
    --   enable = true,
    --   keymaps = {
    --     smart_rename = "grr",
    --   },
    -- },
    -- navigation = {
    --   enable = true,
    --   keymaps = {
    --     goto_definition = "gnd",
    --     list_definitions = "gnD",
    --     list_definitions_toc = "gO",
    --     goto_next_usage = "<a-*>",
    --     goto_previous_usage = "<a-#>",
    --   },
    -- },
  },
})

require('treesitter-context.config').setup({
  enable = true,
})

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local lspconfig = require('lspconfig')
-- local completion = require('completion')
local completion = nil

-- it needs to be global until there is lua API for autocommands
function Only_normal(command)
  if vim.api.nvim_get_mode().mode ~= 'n' then
    return
  end
  command()
end

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
  vim.call('deoplete#custom#buffer_option', 'auto_complete', false)

  vim.api.nvim_command([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
  vim.api.nvim_command([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
  vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
  -- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]])
  -- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua Only_normal(vim.lsp.diagnostic.show_line_diagnostics)]])

  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', 'si', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'sa', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', 'se', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n', 'gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

  if completion ~= nil then
    completion.on_attach(client)
  end
  -- nvim-compe
  require('compe').setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = true,
      buffer = true,
      calc = true,
      nvim_lsp = true,
      nvim_lua = true,
      vsnip = true,
      ultisnips = true,
      emoji = false,
      tags = false,
      spell = false,
      dictionary = true,
      look = false,
      nvim_treesitter = false,
    },
  }, 0)
  require('lsp_signature').on_attach()
end

lspconfig.hls.setup({ on_attach = on_attach })
if vim.fn.executable('clangd') then
  lspconfig.clangd.setup({ on_attach = on_attach })
elseif vim.fn.executable('ccls') then
  lspconfig.ccls.setup({ on_attach = on_attach })
end
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.sumneko_lua.setup({
  cmd = { '/usr/bin/lua-language-server' },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
lspconfig.dhall_lsp_server.setup({ on_attach = on_attach })
lspconfig.pylsp.setup({
  on_attach = on_attach,
  root_dir = function(fname)
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      '.env',
      '.git',
    }
    return lspconfig.util.root_pattern(unpack(root_files))(fname)
      or lspconfig.util.find_git_ancestor(fname)
      or lspconfig.util.path.dirname(fname)
  end,
})

-- lspconfig.rust_analyzer.setup({ on_attach=on_attach })
local opts = {
  tools = { -- rust-tools options
    autoSetHints = true,
    hover_with_actions = true,

    runnables = {
      use_telescope = true,
    },

    debuggables = {
      use_telescope = true,
    },

    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = '<- ',
      other_hints_prefix = '=> ',
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
    },

    hover_actions = {
      border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      },
      auto_focus = false,
    },
  },
  server = { on_attach = on_attach }, -- rust-analyer options
}
require('rust-tools').setup(opts)

-- completion-nvim settings
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.g.completion_matching_smart_case = 1
vim.g.completion_sorting = 'alphabet'
vim.g.completion_items_priority = {
  Field = 11,
  Method = 10,
  Property = 9,
  Function = 7,
  Variables = 6,
  Struct = 6,
  Interfaces = 6,
  Constant = 6,
  Class = 6,
  Keyword = 5,
  Treesitter = 4,
  File = 2,
  TabNine = 1,
  Buffers = 0,
}

require('hop').setup({ keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 })
