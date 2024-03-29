require("lint").linters_by_ft = {
	javascript = { "biomejs" },
	typescript = { "biomejs" },
	python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
