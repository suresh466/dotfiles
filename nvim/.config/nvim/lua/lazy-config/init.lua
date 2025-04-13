local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options

require("lazy").setup({
	{ "tpope/vim-fugitive" },
	{
		"suresh466/tailwind-sorter.nvim",
		branch = "fix-template-literal-spaces",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm ci && npm run build",
		config = function()
			require("tailwind-sorter").setup({
				on_save_enabled = true,
				-- trim_spaces = true,
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"yetone/avante.nvim",
		-- config = function()
		-- 	require("avante_lib").load()
		-- end,
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "claude", -- Recommend using Claude
			auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-5-sonnet-20241022",
				temperature = 0,
				max_tokens = 4096,
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = true,
			},
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				sidebar = {
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},
			hints = { enabled = true },
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "left", -- the position of the sidebar
				wrap = true, -- similar to vim.o.wrap
				width = 40, -- default % based on available width
				sidebar_header = {
					align = "center", -- left, center, right for title
					rounded = true,
				},
			},
			highlights = {
				---@type AvanteConflictHighlights
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},
			--- @class AvanteConflictUserConfig
			diff = {
				autojump = true,
				---@type string | fun(): any
				list_opener = "copen",
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante", "copilot-chat" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	{
		"epwalsh/pomo.nvim",
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
		dependencies = {
			-- Optional, but highly recommended if you want to use the "Default" timer
			"rcarriga/nvim-notify",
		},
		opts = {
			sticky = false,
			-- You can optionally define custom timer sessions.
			sessions = {
				-- Example session configuration for a session called "pomodoro".
				pomodoro = {
					{ name = "Work", duration = "25m" },
					{ name = "Short Break", duration = "5m" },
					{ name = "Work", duration = "25m" },
					{ name = "Short Break", duration = "5m" },
					{ name = "Work", duration = "25m" },
					{ name = "Short Break", duration = "5m" },
					{ name = "Work", duration = "25m" },
					{ name = "Long Break", duration = "10m" },
				},
			},
		},
		keys = {
			{
				"<leader>ts",
				":TimerStart Session pomodoro<CR>",
				{ desc = "start pomodoro session" },
			},
			{
				"<leader>tt",
				function()
					require("telescope").extensions.pomodori.timers()
				end,
				{ desc = "Manage Pomodori Timers" },
			},
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"mbbill/undotree",
		keys = {
			{
				"<leader>ut",
				"<cmd>UndotreeToggle<cr>",
				{ desc = "Toggle Undotree" },
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			win = {
				wo = {
					-- transparency
					winblend = 20,
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	"ellisonleao/gruvbox.nvim",
	"nvim-lualine/lualine.nvim",

	--requires
	{ "echasnovski/mini.icons", version = false },
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",

	--fuzzy finder
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },

	--mason
	"williamboman/mason.nvim",

	--treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/nvim-treesitter-context",
	--to be tried
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	},
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	},

	--lsp plugs
	"neovim/nvim-lspconfig", -- Configurations collection for inbuilt LSP client

	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"hrsh7th/cmp-buffer", -- LSP source for nvim-cmp
	"hrsh7th/cmp-path", -- LSP source for nvim-cmp
	"hrsh7th/cmp-cmdline", -- LSP source for nvim-cmp
	"rcarriga/cmp-dap", -- LSP source for nvim-cmp

	"L3MON4D3/LuaSnip", -- Snippets plugin
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"rafamadriz/friendly-snippets",

	"folke/neodev.nvim", -- for lua_ls lsp server config
	"onsails/lspkind.nvim", -- for vs-code like pictograms in builtin nvim lsp

	--debugging plugs
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio", -- for async stuff
			"rcarriga/nvim-dap-ui", --ui for dap
			"theHamsta/nvim-dap-virtual-text", --virtual text support
			"mfussenegger/nvim-dap-python", --python-extension for DAP conf
		},
	},

	-- Test framework
	--{
	--    'nvim-neotest/neotest',
	--    dependencies = {
	--        'nvim-neotest/neotest-python',
	--    },

	--},
	--commentary
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},

	--linting
	"mfussenegger/nvim-lint",

	--formatting
	"stevearc/conform.nvim",

	--ai
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-h>",
						accept_line = "<C-b>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			{ "MeanderingProgrammer/render-markdown.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		-- opts = {
		-- 	model = "claude-3.7-sonnet",
		-- 	auto_follow_cursor = false,
		-- 	window = {
		-- 		width = 0.45,
		-- 	},
		-- 	highlight_headers = false,
		-- 	separator = "---",
		-- 	error_header = "> [!ERROR] Error",
		-- },
		config = function()
			require("copilotchat-config").setup()
		end,
	},

	-- css
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
					mode = "virtualtext",
				},
			})
		end,
	},

	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
})
