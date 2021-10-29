require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 })

require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "„", -- <a-v>
			node_incremental = "„",
			node_decremental = "‘", --- <a-s-v>
			scope_incremental = "sv",
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
				smart_rename = "grr",
			},
		},
		navigation = {
			enable = false,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
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
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["xl"] = "@parameter.inner",
			},
			swap_previous = {
				["xh"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})

require("treesitter-context.config").setup({
	enable = true,
})

require("tabout").setup({
	tabkey = "",
	backwards_tabkey = "",
})

if vim.g.my_use_nvim_autopairs then
	require("nvim-autopairs").setup()

	local Rule = require("nvim-autopairs.rule")
	local npairs = require("nvim-autopairs")
	npairs.add_rule(Rule("„", "”"))
	npairs.add_rule(Rule("’", "’"))
end

local function replace_keycodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_binding()
	if vim.fn["vsnip#available"](1) ~= 0 then
		return replace_keycodes("<Plug>(vsnip-expand-or-jump)")
	elseif vim.fn.pumvisible() ~= 0 then
		return replace_keycodes("<C-n>")
	else
		return replace_keycodes("<Plug>(Tabout)")
	end
end

function _G.s_tab_binding()
	if vim.fn["vsnip#jumpable"](-1) ~= 0 then
		return replace_keycodes("<Plug>(vsnip-jump-prev)")
	elseif vim.fn.pumvisible() ~= 0 then
		return replace_keycodes("<C-p>")
	else
		return replace_keycodes("<Plug>(TaboutBack)")
	end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", { expr = true, unique = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", { expr = true, unique = true })

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

-- LSP
-- it needs to be global until there is lua API for autocommands
function Only_normal(command)
	if vim.api.nvim_get_mode().mode ~= "n" then
		return
	end
	command()
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
})

local symbols = {
	Array = "[]",
	Boolean = "⊨",
	-- Class = '𝓒'
	-- Class = '🅒',
	Class = "∴",
	-- Color = '☀',
	-- Color = '⛭',
	Color = "🖌",
	-- Constant = 'π',
	Constant = "𝜋",
	Constructor = "⬡",
	-- Constructor = '⌬',
	-- Constructor = '⎔',
	-- Constructor = '⚙',
	-- Constructor = 'ᲃ',
	-- Enum = '',
	Enum = "ℰ",
	EnumMember = "",
	Event = "",
	-- Field = '→',
	-- Field = '∴',
	Field = "🠶",
	File = "",
	Folder = "",
	Function = "ƒ",
	-- Function = 'λ',
	Interface = "",
	Key = "🗝",
	Keyword = "🗝",
	Method = "𝘮",
	-- Method = 'λ',
	Module = "📦",
	Namespace = "ns",
	Object = "⦿",
	Operator = "≠",
	-- Operator = '±',
	Package = "⚙",
	-- Property = '::',
	Property = "∷",
	-- Reference = '⌦',
	Reference = "⊷",
	-- Reference = '⊶',
	-- Reference = '⊸',
	-- Snippet = '',
	-- Snippet = '↲',
	-- Snippet = '♢',
	-- Snippet = '<>',
	Snippet = "{}",
	-- Struct = "𝓢",
	Struct = "",
	Text = "#",
	-- Text = '𝓐',
	-- Text = '♯',
	-- Text = 'ⅵ',
	-- Text = "¶",
	-- Text = "𝒯",
	-- Text = "𝓣",
	-- Text = "𐄗",
	TypeParameter = "×",
	-- TypeParameter = "𝙏",
	-- TypeParameter = "Ŧ",
	-- TypeParameter = "T",
	Unit = "()",
	-- Value           =
	-- Variable = '𝛼',
	-- Variable = 'χ',
	Variable = "𝓧",
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

local signs = { Error = "𐄂", Warning = "■", Hint = "⟡", Information = "ɨ" }

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local lspkind_comparator = function(conf)
	local lsp_types = require("cmp.types").lsp
	return function(entry1, entry2)
		if entry1.source.name ~= "nvim_lsp" then
			if entry2.source.name == "nvim_lsp" then
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

local compare = require("cmp.config.compare")
local cmp = require("cmp")
local mapping = {
	["<C-d>"] = cmp.mapping.scroll_docs(4),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.close(),
	-- ['<CR>'] = cmp.mapping.confirm({
	--   behavior = cmp.ConfirmBehavior.Replace,
	--   select = true,
	-- }),
	-- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	-- ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
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

	preselect = "none",

	mapping = mapping,

	formatting = {
		deprecated = true,
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			-- vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
			vim_item.kind = symbols[vim_item.kind]

			-- set a name for each source
			vim_item.menu = "[" .. entry.source.name .. "]"
			return vim_item
		end,
	},

	-- experimental = {
	--   ghost_text = false,
	-- },

	-- sources = {{name = 'nvim_lua'}, {name = 'buffer'}},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "spell" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "buffer" },
	},
})
require("nvim-autopairs.completion.cmp").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` after select function or method item
	auto_select = true, -- automatically select the first item
})

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(_client, bufnr)
	vim.call("deoplete#custom#buffer_option", "auto_complete", false)

	vim.api.nvim_command([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
	vim.api.nvim_command([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
	vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
	-- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]])
	-- vim.api.nvim_command([[autocmd CursorMoved <buffer> lua Only_normal(vim.lsp.diagnostic.show_line_diagnostics)]])

	map("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	map("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
	map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	map("n", "g/", "<cmd>lua vim.lsp.buf.references()<CR>")
	map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	map("n", "gl", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	map("n", "gs", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
	map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	map("n", "g.", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
	map("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>")
	map("n", "gQ", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
	map("n", "gy", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
	map("n", "gz", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")

	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "single",
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

vim.fn.sign_define("LightBulbSign", { text = "᯾", texthl = "", linehl = "", numhl = "" })
vim.cmd(
	[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = true, priority = 50, }, virtual_text = { enabled = true, text = "⟡" }})]]
)

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
lspconfig.hls.setup({ on_attach = on_attach, capabilities = capabilities })
if vim.fn.executable("clangd") then
	lspconfig.clangd.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			map(
				"n",
				"<C-w>a",
				'<cmd>lua vim.lsp.buf_request(0, "textDocument/switchSourceHeader", {uri=vim.uri_from_bufnr(0)}, nil)<CR>'
			)
			map(
				"n",
				"gh",
				'<cmd>lua vim.lsp.buf_request(0, "textDocument/switchSourceHeader", {uri=vim.uri_from_bufnr(0)}, nil)<CR>'
			)
		end,
		capabilities = capabilities,
		handlers = {
			["textDocument/switchSourceHeader"] = function(err, result, _ctx, _config)
				if result then
					local filename = vim.uri_to_fname(result)
					vim.api.nvim_command("edit " .. filename)
				elseif err then
					print(vim.inspect(err))
				else
					print("No alternate file found")
				end
			end,
		},
	})
elseif vim.fn.executable("ccls") then
	lspconfig.ccls.setup({ on_attach = on_attach, capabilities = capabilities })
end
lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.sumneko_lua.setup({
	cmd = { "/usr/bin/lua-language-server" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
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
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			".env",
			".git",
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
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
		},

		hover_actions = {
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
			auto_focus = false,
		},
	},
	server = { on_attach = on_attach, capabilities = capabilities }, -- rust-analyer options
}
require("rust-tools").setup(rust_opts)

local default_outline_symbols = require("symbols-outline.config").defaults.symbols
local outline_symbols = {}
for type, definition in pairs(default_outline_symbols) do
	local my_definition = { hl = definition.hl, icon = symbols[type] or definition.icon }
	outline_symbols[type] = my_definition
end
-- print(vim.inspect(outline_symbols))

--- Plug 'stevearc/aerial.nvim'
vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = "right",
	width = 25,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = true,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = outline_symbols,
}

function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end
