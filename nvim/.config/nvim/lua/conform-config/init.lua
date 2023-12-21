local conform = require('conform')
conform.setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		javascript = { 'biome' },
	},
})

conform.formatters.stylua = {
	prepend_args = { '--quote-style', 'ForceSingle' },
}

conform.formatters.biome = {
	prepend_args = { 'format', '--quote-style', 'single' },
}

vim.api.nvim_create_autocmd('BufWritePre', {
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
