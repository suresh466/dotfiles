local slow_format_filetypes = {}
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome", "biome-organize-imports" },
		javascriptreact = { "biome", "biome-organize-imports" },
		typescript = { "biome", "biome-organize-imports" },
		typescriptreact = { "biome", "biome-organize-imports" },
		python = { "ruff_format", "ruff_organize_imports" },
		htmldjango = { "djlint" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
	format_on_save = function(bufnr)
		if slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		local function on_format(err)
			if err and err:match("timeout$") then
				slow_format_filetypes[vim.bo[bufnr].filetype] = true
			end
		end

		return { timeout_ms = 200, lsp_format = "fallback" }, on_format
	end,

	format_after_save = function(bufnr)
		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		return { lsp_format = "fallback" }
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
