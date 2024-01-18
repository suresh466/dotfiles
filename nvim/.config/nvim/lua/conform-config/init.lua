local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome" },
		typescript = { "biome" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})

-- enable imports sorting on format with biome
conform.formatters.biome = {
	prepend_args = { "check", "sort", "--apply", "--linter-enabled", "false" },
}
