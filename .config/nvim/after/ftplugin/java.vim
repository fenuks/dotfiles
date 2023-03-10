if exists('b:did_java_ftplugin')
    finish
endif
let b:did_java_ftplugin = 1

setlocal softtabstop=2
setlocal shiftwidth=2

" fold imports and comments
function! FoldJavaExpr(lineno) abort
    return getline(a:lineno) =~# '^import\|^\s*\(\*\|\/\*\)'
endfunction

setlocal foldexpr=FoldJavaExpr(v:lnum)
setlocal foldmethod=expr

setlocal includeexpr=substitute(v:fname,'\\.','/','g') " expression to change gf filename mapping
setlocal colorcolumn=100

if exists(':YcmCompleter')
call ConfigureYcm()
let g:ycm_semantic_triggers.java = ['.', '@', '::']
let g:JavaComplete_EnableDefaultMappings = 0
endif

" autocmd FileType java setlocal makeprg=mvn errorformat='[%tRROR]\ %f:[%l]\ %m,%-G%.%#'
nnoremap <unique> <buffer> <silent> <Leader>ii <Plug>(JavaComplete-Imports-AddSmart)
nnoremap <unique> <buffer> <silent> <Leader>iI <Plug>(JavaComplete-Imports-Add)
nnoremap <unique> <buffer> <silent> <Leader>ia <Plug>(JavaComplete-Imports-AddMissing)
nnoremap <unique> <buffer> <silent> <Leader>id <Plug>(JavaComplete-Imports-RemoveUnused)

nnoremap <unique> <buffer> <silent> <Leader>am <Plug>(JavaComplete-Generate-AbstractMethods)
nnoremap <unique> <buffer> <silent> <Leader>aA <Plug>(JavaComplete-Generate-Accessors)
nnoremap <unique> <buffer> <silent> <Leader>as <Plug>(JavaComplete-Generate-AccessorSetter)
nnoremap <unique> <buffer> <silent> <Leader>ag <Plug>(JavaComplete-Generate-AccessorGetter)
nnoremap <unique> <buffer> <silent> <Leader>aa <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nnoremap <unique> <buffer> <silent> <Leader>ats <Plug>(JavaComplete-Generate-ToString)
nnoremap <unique> <buffer> <silent> <Leader>aeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nnoremap <unique> <buffer> <silent> <Leader>aI <Plug>(JavaComplete-Generate-Constructor)
nnoremap <unique> <buffer> <silent> <Leader>ai <Plug>(JavaComplete-Generate-DefaultConstructor)
nnoremap <unique> <buffer> <silent> <Leader>ac <Plug>(JavaComplete-Generate-NewClass)
nnoremap <unique> <buffer> <silent> <Leader>aC <Plug>(JavaComplete-Generate-ClassInFile)

if has('nvim')
nnoremap <unique> <buffer> <silent> xo <Cmd>lua require('jdtls').organize_imports()<CR>
nnoremap <unique> <buffer> <silent> xv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap <unique> <buffer> <silent> xv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap <unique> <buffer> <silent> xc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap <unique> <buffer> <silent> xc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap <unique> <buffer> <silent> xm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

" nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
" nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

lua << EOF
local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true, unique = true })
end

local jdtls = require('jdtls')
local jdtls_setup = require('jdtls.setup')

local on_attach = function(_client, _bufnr)
  vim.call('deoplete#custom#buffer_option', 'auto_complete', false)

  -- TODO: refactor, copied from init.lua
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
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
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


  jdtls_setup.add_commands()
  -- jdtls.setup_dap()
  require'lsp-status'.register_progress()
end

local project_dir = jdtls_setup.find_root({'.git', 'mvnw', 'gradlew'}) or vim.fn.getcwd()
local project_name = vim.fn.fnamemodify(project_dir, ':p:h:t')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  --- cmd = {
  ---   "java",
  ---   "-javaagent:/usr/share/java/lombok/lombok.jar",
  ---   "-Xbootclasspath/a:/usr/share/java/lombok/lombok.jar",
  ---   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  ---   "-Dosgi.bundles.defaultStartLevel=4",
  ---   "-Declipse.product=org.eclipse.jdt.ls.core.product",
  ---   "-noverify",
  ---   "-Dlog.level=ALL",
  ---   "-Xms2g",
  ---   "--add-modules=ALL-SYSTEM",
  ---   "--add-opens", "java.base/java.util=ALL-UNNAMED",
  ---   "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  ---   "-jar", vim.fn.expand("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
  ---   "-configuration", "/usr/share/java/jdtls/config_linux",
  ---   "-data", "/home/fenuks/.cache/jdtls/workspaces/" .. project_name
  --- },
  cmd = {
    "jdtls",
    "-javaagent:/usr/share/java/lombok/lombok.jar",
    "-Xbootclasspath/a:/usr/share/java/lombok/lombok.jar",
    "-noverify",
    "-Dlog.level=ALL",
    "-Xms2g",
    "-data", "/home/fenuks/.cache/jdtls/workspaces/" .. project_name
  },
  flags = {
    allow_incremental_sync = true,
  },
  on_attach = on_attach,
  init_options = {
    extendedClientCapabilities = extendedClientCapabilities
  },
  capabilities = capabilities,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        }
      },
    }
  }
}

require('jdtls').start_or_attach(config)
EOF
endif
