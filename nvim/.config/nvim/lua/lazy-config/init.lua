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
				"<leader>pts",
				":TimerStart Session pomodoro<CR>",
				{ desc = "start pomodoro session" },
			},
			{
				"<leader>pt",
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
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
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
