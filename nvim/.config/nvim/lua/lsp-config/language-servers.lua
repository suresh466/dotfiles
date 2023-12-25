-- Setup language servers.
local lspconfig = require("lspconfig")
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

local servers = {
	"pyright",
	"lua_ls",
	"tsserver",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end

-- example to setup sumneko and enable call snippets
lspconfig.lua_ls.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "cl", "<cmd>LspInfo<cr>", vim.tbl_extend("force", opts, { desc = "Lsp Info" }))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set({ "n", "i" }, "<C-\\>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
		vim.keymap.set(
			{ "n", "v" },
			"<space>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code Action" })
		)
		vim.keymap.set({ "n", "v" }, "<space>cA", function()
			vim.lsp.buf.code_action({
				context = {
					only = {
						"source",
					},
					diagnostics = {},
				},
			})
		end, vim.tbl_extend("force", opts, { desc = "Source Action" }))

		vim.keymap.set(
			"n",
			"gr",
			"<cmd>Telescope lsp_references<cr>",
			vim.tbl_extend("force", opts, { desc = "References" })
		)
		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end, vim.tbl_extend("force", opts, { desc = "Goto defination" }))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gI", function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
		vim.keymap.set("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end, vim.tbl_extend("force", opts, { desc = "Goto T[y]pe Defination" }))

		vim.keymap.set("n", "<space>cf", function()
			vim.lsp.buf.format({ async = true })
		end, vim.tbl_extend("force", opts, { desc = "Lsp Buf Format" }))
	end,
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = "if_many",
		border = "rounded",
	},
})
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist) --[TODO]
