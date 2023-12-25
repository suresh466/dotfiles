require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "python", "javascript", "typescript" },
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
	},
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
		smart_rename = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
			keymaps = {
				smart_rename = false,
				--smart_rename = "grr",
			},
		},
		navigation = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
			},
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>", -- set to `false` to disable one of the mappings
			node_incremental = "<space>",
			scope_incremental = "<c-space>",
			node_decremental = "<bs>",
		},
	},
	--for the sake of not getting false error
	ignore_install = {},
	modules = {},
})

require("treesitter-context").setup({
	mode = "cursor",
	max_lines = 3,
})

-- Register Treesitter keybindings with which-key
local wk = require("which-key")
wk.register({
	t = {
		n = {
			name = "Treesitter Navigation",
			d = { "Go to Definition" },
			D = { "List Definitions" },
			O = { "List Definitions (TOC)" },
			["<a-*>"] = { "Go to Next Usage" },
			["<a-#>"] = { "Go to Previous Usage" },
		},
		r = {
			r = { "Smart Rename" },
		},
	},
}, { mode = "n" })
