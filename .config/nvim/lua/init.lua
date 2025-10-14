require('hop').setup({ keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 })
vim.keymap.set('n', '<Leader><Leader>b', vim.cmd.HopWordBC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>w', vim.cmd.HopWordAC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>j', vim.cmd.HopLineAC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>k', vim.cmd.HopLineBC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>f', vim.cmd.HopChar1CurrentLineAC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>F', vim.cmd.HopChar1CurrentLineBC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>/', vim.cmd.HopPatternAC, { unique = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>?', vim.cmd.HopPatternBC, { unique = true, silent = true })

require('nvim-ts-autotag').setup({
  filetypes = { 'html', 'xml' },
})

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { 'phpdoc', 'erlang' },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  matchup = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { 'markdown' },
    additional_vim_regex_highlighting = false, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
    enable = true,
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
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ad'] = '@class.outer',
        ['id'] = '@class.inner',
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
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- disabled due to severe performance regression
-- https://github.com/nvim-treesitter/nvim-treesitter-context/issues/410
require('treesitter-context').setup({
  enable = true,
  max_lines = 5,
})

require('tabout').setup({
  tabkey = '',
  backwards_tabkey = '',
})

if vim.g.my_use_nvim_autopairs then
  local Rule = require('nvim-autopairs.rule')
  local npairs = require('nvim-autopairs')
  npairs.setup()
  npairs.add_rule(Rule('„', '”'))
  npairs.add_rule(Rule('‘', '’'))
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Workaround for https://github.com/nvim-telescope/telescope.nvim/issues/1048
local multiopen = function(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)

  local results = vim.fn.getqflist()

  for _, result in ipairs(results) do
    local current_file = vim.fn.bufname()
    local next_file = vim.fn.bufname(result.bufnr)

    if current_file == '' then
      vim.api.nvim_command('edit' .. ' ' .. next_file)
    else
      vim.api.nvim_command(open_cmd .. ' ' .. next_file)
    end
  end

  vim.api.nvim_command('cd .')
end

local function multi_selection_open_edit(prompt_bufnr)
  multiopen(prompt_bufnr, 'edit')
end

local function multi_selection_open_vsplit(prompt_bufnr)
  multiopen(prompt_bufnr, 'vsplit')
end

local function multi_selection_open_split(prompt_bufnr)
  multiopen(prompt_bufnr, 'split')
end

local function multi_selection_open_tab(prompt_bufnr)
  multiopen(prompt_bufnr, 'tabedit')
end

require('telescope').load_extension('fzy_native')
require('telescope').setup({
  defaults = {
    -- layout_strategy = 'vertical',
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.99,
      vertical = {
        preview_cutoff = 0,
      },
      horizontal = {
        preview_cutoff = 0,
      },
    },
  },
  pickers = {
    find_files = {
      mappings = {
        i = {
          ['<CR>'] = multi_selection_open_edit,
          ['<C-v>'] = multi_selection_open_vsplit,
          ['<C-s>'] = multi_selection_open_split,
          ['<C-t>'] = multi_selection_open_tab,
        },
      },
    },
  },
})

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', 'z=', telescope_builtin.spell_suggest, { unique = true, silent = true })
vim.keymap.set('n', 'xx', telescope_builtin.find_files, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>fl', telescope_builtin.find_files, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>fv', telescope_builtin.git_files, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>fd', function()
  telescope_builtin.find_files({ cwd = require('telescope.utils').buffer_dir() })
end, { unique = true, silent = true })
vim.keymap.set('n', '<leader>fs', function()
  telescope_builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, { unique = true, silent = true })
vim.keymap.set('n', 'g?', telescope_builtin.current_buffer_tags, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>gt', telescope_builtin.tags, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>gh', telescope_builtin.oldfiles, { unique = true, silent = true })
vim.keymap.set('n', '<Leader>bl', telescope_builtin.buffers, { unique = true, silent = true })

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true, unique = true })
end

local map_nonunique = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

-- LSP
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
      if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
        vim.fn['UltiSnips#ExpandSnippetOrJump']()
      elseif cmp.visible() then
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
  --   ghost_text = true,
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
local on_attach = function(_client, _bufnr)
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
  map('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  -- actions
  -- map('n', 'g.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', 'x.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('v', 'x.', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
  map('n', 'xr', '<cmd>lua vim.lsp.buf.rename()<CR>')

  -- formatting
  map('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n', 'gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  map('v', 'gQ', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')

  -- conflicts with doc box in autocomplete
  -- require('lsp_signature').on_attach({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   handler_opts = {
  --     border = 'single',
  --   },
  -- }, bufnr)
end

vim.fn.sign_define('LightBulbSign', { text = '᯾', texthl = '', linehl = '', numhl = '' })
vim.cmd(
  [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = true, priority = 50, }, virtual_text = { enabled = true, text = "⟡" }})]]
)

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.hls.setup({ on_attach = on_attach, capabilities = capabilities })
if vim.fn.executable('clangd') == 1 then
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
lspconfig.nil_ls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.zls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
if vim.fn.executable('lemminx') == 1 then
  lspconfig.lemminx.setup({ on_attach = on_attach, capabilities = capabilities })
end
if vim.fn.executable('/usr/bin/lua-language-server') == 1 then
  lspconfig.lua_ls.setup({
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
end
lspconfig.dhall_lsp_server.setup({ on_attach = on_attach, capabilities = capabilities })

if vim.fn.executable('pylsp') == 1 then
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
      return vim.lsp.util.root_pattern(unpack(root_files))(fname)
        or vim.lsp.util.find_git_ancestor(fname)
        or vim.lsp.util.path.dirname(fname)
    end,
  })
end

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

require('orgmode').setup({
  org_agenda_files = { '~/Dokumenty/notatki/*' },
  -- org_default_notes_file = '~/Dokumenty/notatki/zadania.org',
  -- org_highlight_latex_and_related = 'entities',
  mappings = {
    disable_all = false,
    org = {
      org_cycle = ',<TAB>',
      org_global_cycle = ',<S-TAB>',
    },
  },
})

local iron = require('iron.core')

iron.setup({
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = { 'zsh' },
      },
      -- python = {
      --   command = {"ipython"}
      -- }
    },
    -- How the repl window will be displayed
    -- See below for more information
    -- repl_open_cmd = require('iron.view').bottom(40),
    repl_open_cmd = require('iron.view').split.vertical.botright(70),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = '<space>sc',
    visual_send = '<space>sc',
    send_file = '<space>sf',
    send_line = '<space>sl',
    send_mark = '<space>sm',
    mark_motion = '<space>mc',
    mark_visual = '<space>mc',
    remove_mark = '<space>md',
    cr = '<space>s<cr>',
    interrupt = '<space>s<space>',
    exit = '<space>sq',
    clear = '<space>cl',
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
})

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function ansi_colorize()
  vim.opt.listchars = { space = " " }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
  vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd("TextChanged", { buffer = buf, command = "normal! G$" })
  vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })
  vim.opt.modifiable = true
  vim.opt.undolevels = 1000
end
