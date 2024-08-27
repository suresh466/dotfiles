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
wk.add({
	{ "t", group = "Treesitter" },
	{ "tn", group = "Treesitter Navigation" },
	{
		"tnd",
		"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_definition()<CR>",
		desc = "Go to Definition",
	},
	{
		"tnD",
		"<cmd>lua require('nvim-treesitter.refactor.navigation').list_definitions()<CR>",
		desc = "List Definitions",
	},
	{
		"tnO",
		"<cmd>lua require('nvim-treesitter.refactor.navigation').list_definitions_toc()<CR>",
		desc = "List Definitions (TOC)",
	},
	{
		"tn<a-*>",
		"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_next_usage()<CR>",
		desc = "Go to Next Usage",
	},
	{
		"tn<a-#>",
		"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_previous_usage()<CR>",
		desc = "Go to Previous Usage",
	},
	{ "trr", "<cmd>lua require('nvim-treesitter.refactor.smart_rename').smart_rename()<CR>", desc = "Smart Rename" },
}, { mode = "n" })
