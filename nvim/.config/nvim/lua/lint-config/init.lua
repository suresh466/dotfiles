local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	python = { "ruff" },
	html = { "htmlhint" },
	htmldjango = { "djlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Function to get the linters for the current file type
local function get_linters_for_ft(ft)
	local linters = lint.linters_by_ft[ft] or {}
	return linters
end

-- Function to display the linters for the current buffer
local function show_linters()
	local ft = vim.bo.filetype
	local linters = get_linters_for_ft(ft)
	if #linters == 0 then
		print("No linters configured for file type: " .. ft)
	else
		print("Linters configured for file type: " .. ft)
		for _, linter in ipairs(linters) do
			print("  - " .. linter)
		end
	end
end

-- Create a custom command to display the linters
vim.api.nvim_create_user_command("LintInfo", show_linters, {})
