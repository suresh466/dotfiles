-- luasnip setup
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 4 },
	},
	formatting = {
		format = function(entry, vim_item)
			-- apply tailwindcss formatter
			vim_item = tailwindcss_colorizer_cmp.formatter(entry, vim_item)

			-- apply lspkind formatter
			vim_item = lspkind.cmp_format({
				mode = "symbol_text", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				-- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				ellipsis_char = "...",
				menu = {
					nvim_lsp = "[LSP]",
					luasnip = "[snip]",
					buffer = "[buf]",
					path = "[path]",
					dap = "[dap]",
				},
			})(entry, vim_item)

			return vim_item
		end,
	},
	experimental = {
		ghost_text = false,
	},
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- dap-ui completion
cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
})
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})
