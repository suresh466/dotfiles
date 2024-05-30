local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		python = { "ruff_format", "ruff_fix" },
		htmldjango = { "djlint" },
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

-- just perform import sorting no auto fixing
conform.formatters.ruff_fix = {
	args = { "--select", "I", "--fix", "-e", "-n", "--stdin-filename", "$FILENAME" },
}
