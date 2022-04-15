require('hop').setup({ keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 })

require('nvim-ts-autotag').setup({
  filetypes = { 'html', 'xml' },
})

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = {
    enable = true,
    disable = { 'org' }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = false,
      keymaps = {
        smart_rename = 'grr',
      },
    },
    navigation = {
      enable = false,
      keymaps = {
        goto_definition = 'gnd',
        list_definitions = 'gnD',
        list_definitions_toc = 'gO',
        goto_next_usage = '<a-*>',
        goto_previous_usage = '<a-#>',
      },
    },
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['xl'] = '@parameter.inner',
      },
      swap_previous = {
        ['xh'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
        [']:'] = '@dict-pair',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
        ['[:'] = '@dict-pair',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
})

require('treesitter-context.config').setup({
  enable = true,
})

require('tabout').setup({
  tabkey = '',
  backwards_tabkey = '',
})

if vim.g.my_use_nvim_autopairs then
  require('nvim-autopairs').setup()

  local Rule = require('nvim-autopairs.rule')
  local npairs = require('nvim-autopairs')
  npairs.add_rule(Rule('„', '”'))
  npairs.add_rule(Rule('’', '’'))
end

local function replace_keycodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

require('telescope').load_extension('fzy_native')
require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    -- layout_strategy = 'horizontal',
    layout_config = { width = 0.9 },
  },
})

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true, unique = true })
end

local map_nonunique = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

-- LSP
-- it needs to be global until there is lua API for autocommands
function Only_normal(command)
  if vim.api.nvim_get_mode().mode ~= 'n' then
    return
  end
  command()
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

local symbols = {
  -- Array = '[]',
  Array = '',
  Boolean = '⊨',
  -- Class = '𝓒'
  -- Class = '🅒',
  Class = '∴',
  -- Color = '☀',
  -- Color = '⛭',
  Color = '🖌',
  -- Constant = 'π',
  Constant = '𝜋',
  Constructor = '⬡',
  -- Constructor = '⌬',
  -- Constructor = '⎔',
  -- Constructor = '⚙',
  -- Constructor = 'ᲃ',
  -- Enum = '',
  Enum = 'ℰ',
  EnumMember = '',
  Event = '',
  -- Field = '→',
  -- Field = '∴',
  Field = '🠶',
  File = '',
  Folder = '',
  Function = 'ƒ',
  -- Function = 'λ',
  Interface = '',
  Key = '🗝',
  Keyword = '🗝',
  Method = '𝘮',
  -- Method = 'λ',
  Module = '📦',
  Namespace = 'ns',
  Object = '⦿',
  Operator = '≠',
  -- Operator = '±',
  Package = '⚙',
  -- Property = '::',
  Property = '∷',
  -- Reference = '⌦',
  Reference = '⊷',
  -- Reference = '⊶',
  -- Reference = '⊸',
  -- Snippet = '',
  -- Snippet = '↲',
  -- Snippet = '♢',
  -- Snippet = '<>',
  Snippet = '{}',
  -- Struct = "𝓢",
  Struct = '',
  Text = '#',
  -- Text = '𝓐',
  -- Text = '♯',
  -- Text = 'ⅵ',
  -- Text = "¶",
  -- Text = "𝒯",
  -- Text = "𝓣",
  -- Text = "𐄗",
  TypeParameter = '×',
  -- TypeParameter = "𝙏",
  -- TypeParameter = "Ŧ",
  -- TypeParameter = "T",
  Unit = '()',
  -- Value           =
  -- Variable = '𝛼',
  -- Variable = 'χ',
  Variable = '𝓧',
  -- Variable = '𝛸',
  -- Variable = 'α',
  -- Variable = '≔',
}
-- ⊕ † ፨ ᯾ ⁂ ∎ ∹ ☖ ⚐ 🕮 🗈 🗉 🗈 🗉 ⬠  ⬡  ⮺  ⮻ ⯐  ⯒ ⟡ ✐  ✎ ꒾꙳ ꥟ ⤙ ⤚ ⤛ ⤜ 𐄂 𐄔 𐄘  𐄜 𐄝 𐄷 𐄕 𐄗  𐄎 𐅽  𐅼 𐆓 𐊌  𐊾 𐦖 𑁍
-- 🗩 🗛 🗗  🗁  🗀  🕸 ✗○◐●✓
--
-- info = "",
-- warning = "", -- ☣️
-- error = "" -- 🈲

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = symbols[kind] or kind
end

local signs = { Error = '𐄂', Warning = '■', Hint = '⟡', Information = 'ɨ' }

for type, icon in pairs(signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local compare = require('cmp.config.compare')
local cmp = require('cmp')
local mapping = {
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ['<C-y>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }),
  --- FIXME temporary workaround
  ['<C-b>'] = function(_fallback)
    for _ = 1, 10 do
      cmp.mapping.select_prev_item()(nil)
    end
  end,
  ['<C-f>'] = function(_fallback)
    for _ = 1, 10 do
      cmp.mapping.select_next_item()(nil)
    end
  end,
  ['<Tab>'] = cmp.mapping({
    i = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
        vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
      else
        fallback()
      end
    end,
    s = function(fallback)
      if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
        vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
      else
        fallback()
      end
    end,
  }),
  ['<S-Tab>'] = cmp.mapping({
    i = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
        return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_backward)'), 'm', true)
      else
        fallback()
      end
    end,
    s = function(fallback)
      if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
        return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_backward)'), 'm', true)
      else
        fallback()
      end
    end,
  }),
  ['<CR>'] = cmp.mapping({
    i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
  }),
}

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },

  sorting = {
    priority_weight = 10,
    -- comparators = {
    -- compare.order,
    -- compare.sort_text,
    -- compare.kind,
    -- compare.offset,
    -- compare.exact,
    -- compare.score,
    -- compare.length,
    -- },
    comparators = {
      compare.score,
      compare.order,
      -- lspkind_comparator({
      --   kind_priority = {
      --     Field = 11,
      --     Property = 11,
      --     Constant = 10,
      --     Enum = 10,
      --     EnumMember = 10,
      --     Event = 10,
      --     Function = 10,
      --     Method = 10,
      --     Operator = 10,
      --     Reference = 10,
      --     Struct = 10,
      --     Variable = 9,
      --     File = 8,
      --     Folder = 8,
      --     Class = 5,
      --     Color = 5,
      --     Module = 5,
      --     Keyword = 2,
      --     Constructor = 1,
      --     Interface = 1,
      --     Snippet = 0,
      --     Text = 1,
      --     TypeParameter = 1,
      --     Unit = 1,
      --     Value = 1,
      --   },
      -- }),
      -- label_comparator,
    },
  },

  event = {},

  preselect = 'none',

  mapping = cmp.mapping.preset.insert(mapping),

  formatting = {
    deprecated = true,
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      -- vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
      vim_item.kind = symbols[vim_item.kind]

      -- set a name for each source
      vim_item.menu = '[' .. entry.source.name .. ']'
      return vim_item
    end,
  },

  -- experimental = {
  --   ghost_text = false,
  -- },

  -- sources = {{name = 'nvim_lua'}, {name = 'buffer'}},

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    -- { name = 'spell' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'orgmode' },
    { name = 'vsnip' },
    { name = 'buffer' },
  },
})
-- function to attach completion and diagnostics when setting up lsp
local on_attach = function(_client, bufnr)
  vim.call('deoplete#custom#buffer_option', 'auto_complete', false)

  vim.api.nvim_command([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
  vim.api.nvim_command([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
  vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
  -- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]])
  -- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua Only_normal(vim.lsp.diagnostic.show_line_diagnostics)]])

  -- symbols under cursor
  -- jump to variable definition
  map('n', '<c-]>', '<cmd>Telescope lsp_definitions<CR>')
  map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  -- jump to variable type definition
  map('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>')
  map('n', ']i', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  -- show usages
  map('n', 'ru', '<cmd>Telescope lsp_references<CR>')
  -- show implementations
  map('n', 'ri', '<cmd>Telescope lsp_implementations<CR>')
  -- show callers
  map('n', 'rci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  -- show callees
  map('n', 'rco', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  -- list all references
  map('n', 'rl', '<cmd>Telescope lsp_workspace_symbols<CR>')

  -- document references
  map('n', 'g0', '<cmd>Telescope lsp_document_symbols<CR>')
  map('n', 'g\\', '<cmd>SymbolsOutline<CR>')

  -- signature
  map_nonunique('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  -- actions
  -- map('n', 'g.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', 'x.', '<cmd>Telescope lsp_code_actions<CR>')
  map('v', 'x.', '<cmd>Telescope lsp_range_code_action<CR>s')
  map('n', 'xr', '<cmd>lua vim.lsp.buf.rename()<CR>')

  -- formatting
  map('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n', 'gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  map('v', 'gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')

  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = 'single',
    },
  }, bufnr)
end

-- require('nvim-lightbulb').update_lightbulb({
--   sign = {
--     enabled = true,
--     -- Priority of the gutter sign
--     priority = 10,
--   },
-- })

vim.fn.sign_define('LightBulbSign', { text = '᯾', texthl = '', linehl = '', numhl = '' })
vim.cmd(
  [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = true, priority = 50, }, virtual_text = { enabled = true, text = "⟡" }})]]
)

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
lspconfig.hls.setup({ on_attach = on_attach, capabilities = capabilities })
if vim.fn.executable('clangd') then
  lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      map('n', '<C-w>a', ':ClangdSwitchSourceHeader<CR>')
      map('n', 'gh', ':ClangdSwitchSourceHeader<CR>')
    end,
    capabilities = capabilities,
  })
elseif vim.fn.executable('ccls') then
  lspconfig.ccls.setup({ on_attach = on_attach, capabilities = capabilities })
end
lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.zls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.lemminx.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.sumneko_lua.setup({
  cmd = { '/usr/bin/lua-language-server' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'unused-local' },
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
lspconfig.dhall_lsp_server.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
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

local rust_opts = {
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
  server = { on_attach = on_attach, capabilities = capabilities }, -- rust-analyer options
}
require('rust-tools').setup(rust_opts)
-- require'lspconfig'.jdtls.setup({cmd = { "jdtls" }})

local default_outline_symbols = require('symbols-outline.config').defaults.symbols
local outline_symbols = {}
for type, definition in pairs(default_outline_symbols) do
  local my_definition = { hl = definition.hl, icon = symbols[type] or definition.icon }
  outline_symbols[type] = my_definition
end

--- Plug 'stevearc/aerial.nvim'
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  width = 25,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { '<Esc>', 'q' },
    goto_location = '<Cr>',
    focus_location = 'o',
    hover_symbol = '<C-space>',
    toggle_preview = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = outline_symbols,
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = 'org',
}

-- require('orgmode').setup({
--   org_agenda_files = { '~/Dokumenty/notatki/*' },
--   org_default_notes_file = '~/Dokumenty/notatki/zadania.org',
--   org_highlight_latex_and_related = 'entities',
--   mappings = {
--     disable_all = false,
--     global = {
--       org_agenda = '<Leader>oa',
--       org_capture = '<Leader>oc',
--     },
--   },
-- })

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end
