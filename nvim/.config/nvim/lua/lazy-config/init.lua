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
		event = "VeryLazy",
		-- opts = {
		-- 	settings = {
		-- 		save_on_toggle = true,
		-- 		sync_on_ui_close = true,
		-- 		key = function()
		-- 			return vim.loop.cwd()
		-- 		end,
		-- 	},
		-- },
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add File",
			},
			{
				"<C-e>",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Quick Menu",
			},
			{
				"<C-j>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Select First",
			},
			{
				"<C-k>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Select Second",
			},
			{
				"<C-l>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Select Third",
			},
			{
				"<C-;>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Select Fourth",
			},
			{
				"<leader>fm",
				function()
					local harpoon = require("harpoon")
					local conf = require("telescope.config").values
					local file_paths = {}
					for _, item in ipairs(harpoon:list().items) do
						table.insert(file_paths, item.value)
					end
					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end,
				desc = "Open Harpoon Window",
			},
		},
		init = function()
			-- Initialize harpoon
			require("harpoon"):setup()
		end,
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
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		init = function()
			vim.o.background = "dark"
		end,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local Util = require("lazyvim.util")
			-- Eviline config for lualine
			-- Author: shadmansaleh
			-- Credit: glepnir
			local lualine = require("lualine")

            -- Color table for highlights
            -- stylua: ignore
            local colors = {
                bg       = '#202328',
                fg       = '#bbc2cf',
                yellow   = '#ECBE7B',
                cyan     = '#008080',
                darkblue = '#081633',
                green    = '#98be65',
                orange   = '#FF8800',
                violet   = '#a9a1e1',
                magenta  = '#c678dd',
                blue     = '#51afef',
                red      = '#ec5f67',
            }

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = {
						-- We are going to use lualine_c and lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x ot right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = colors.blue }, -- Sets highlighting of component
				padding = { left = 0, right = 1 }, -- We don't need space before this
			})

			ins_left({
				-- mode component
				function()
					return ""
				end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({
				-- filesize component
				"filesize",
				cond = conditions.buffer_not_empty,
			})

			ins_left({
				-- rootdir
				function()
					local root = Util.root.get({ normalize = true })
					local cwd = vim.fn.getcwd()

					if root ~= cwd then
						cwd = vim.fs.basename(cwd)
					else
						cwd = "-"
					end

					local formatted_string = vim.fs.basename(root) .. "(" .. cwd .. ")"

					return formatted_string
				end,
			})

			ins_left({
				-- filename with parent directory
				function()
					local parent_dir = vim.fn.expand("%:p:h:t")
					local filename = vim.fn.expand("%:t")
					return parent_dir .. "/" .. filename
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.yellow, gui = "bold" },
			})

			ins_left({ "location" })

			ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			})

			-- Add components to right sections
			ins_right({
				-- pomodoro timer
				function()
					local ok, pomo = pcall(require, "pomo")
					if not ok then
						return ""
					end

					local timer = pomo.get_first_to_finish()
					if timer == nil then
						return ""
					end

					return "󰄉 " .. tostring(timer)
				end,
			})
			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				-- icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
				icons_enabled = true,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.yellow, gui = "bold" },
			})

			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "柳 ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			ins_right({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			})
			return config
		end,
	},

	--requires
	{ "echasnovski/mini.icons", version = false },
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",

	--fuzzy finder
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },

	--mason
	{ "williamboman/mason.nvim", opts = {} },

	--treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		opts = {
			ensure_installed = { "c", "lua", "python", "javascript", "typescript" },
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			highlight = {
				-- `false` will disable the whole extension
				enable = true,
			},
			refactor = {
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				smart_rename = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
					keymaps = {
						smart_rename = false,
						--smart_rename = "grr",
					},
				},
				navigation = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
					keymaps = {
						goto_definition = "gnd",
						list_definitions = "gnD",
						list_definitions_toc = "gO",
						goto_next_usage = "<a-*>",
						goto_previous_usage = "<a-#>",
					},
				},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>", -- set to `false` to disable one of the mappings
					node_incremental = "<space>",
					scope_incremental = "<c-space>",
					node_decremental = "<bs>",
				},
			},
			--for the sake of not getting false error
			ignore_install = {},
			modules = {},
		},
		keys = {
			{ "t", desc = "Treesitter" },
			{ "tn", desc = "Treesitter Navigation" },
			{
				"tnd",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_definition()<CR>",
				desc = "Go to Definition",
			},
			{
				"tnD",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').list_definitions()<CR>",
				desc = "List Definitions",
			},
			{
				"tnO",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').list_definitions_toc()<CR>",
				desc = "List Definitions (TOC)",
			},
			{
				"tn<a-*>",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_next_usage()<CR>",
				desc = "Go to Next Usage",
			},
			{
				"tn<a-#>",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').goto_previous_usage()<CR>",
				desc = "Go to Previous Usage",
			},
			{
				"trr",
				"<cmd>lua require('nvim-treesitter.refactor.navigation').smart_rename()<CR>",
				desc = "Smart Rename",
			},
		},
		config = function(opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context", opts = { mode = "cursor", max_lines = 3 } },
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
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost" },
		opts = {
			linters_by_ft = {
				javascript = { "biomejs" },
				javascriptreact = { "biomejs" },
				typescript = { "biomejs" },
				typescriptreact = { "biomejs" },
				python = { "ruff" },
				html = { "htmlhint" },
				htmldjango = { "djlint" },
			},
		},
		config = function(opts)
			local lint = require("lint")

			-- Set up linters
			lint.linters_by_ft = opts.linters_by_ft

			-- Create autocmd to trigger linting
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					lint.try_lint()
				end,
			})

			-- Add user command for linter info
			vim.api.nvim_create_user_command("LintInfo", function()
				local ft = vim.bo.filetype
				local linters = lint.linters_by_ft[ft] or {}
				if #linters == 0 then
					print("No linters configured for filetype: " .. ft)
				else
					print("Linters configured for filetype: " .. ft)
					for _, linter in ipairs(linters) do
						print("  - " .. linter)
					end
				end
			end, {})
		end,
	},

	--formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
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
				local slow_format_filetypes = {}
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
				local slow_format_filetypes = {}
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_format = "fallback" }
			end,
		},
	},

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
		opts = {
			model = "claude-3.7-sonnet",
			auto_follow_cursor = false,
			window = {
				width = 0.45,
			},
			highlight_headers = false,
			separator = "---",
			error_header = "> [!ERROR] Error",
		},
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
