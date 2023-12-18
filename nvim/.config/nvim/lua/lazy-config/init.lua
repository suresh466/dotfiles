local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)   

-- Example using a list of specs with the default options

require('lazy').setup({
    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({})
        end,
        },
	'ellisonleao/gruvbox.nvim',
	'nvim-tree/nvim-tree.lua',
	'nvim-lualine/lualine.nvim',


	--requires
	'kyazdani42/nvim-web-devicons',
	'nvim-lua/plenary.nvim',

	--fuzzy finder
	{'nvim-telescope/telescope.nvim', branch = '0.1.x'},

	--treesitter
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',},
	'nvim-treesitter/nvim-treesitter-refactor',
	'nvim-treesitter/nvim-treesitter-context',
    --to be tried
    {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup({})
        end,
    },
    {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup({})
        end,
    },

    --lsp plugs
    'neovim/nvim-lspconfig', -- Configurations collection for inbuilt LSP client

    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- LSP source for nvim-cmp
    'hrsh7th/cmp-path', -- LSP source for nvim-cmp
    'hrsh7th/cmp-cmdline', -- LSP source for nvim-cmp

    'L3MON4D3/LuaSnip', -- Snippets plugin
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'rafamadriz/friendly-snippets',

    'jose-elias-alvarez/null-ls.nvim', -- provides lsp hooks
    'folke/neodev.nvim', -- for lua_ls lsp server config
    'onsails/lspkind.nvim', -- for vs-code like pictograms in builtin nvim lsp

    --debugging plugs
    {
        'mfussenegger/nvim-dap',
        dependencies = {
                'rcarriga/nvim-dap-ui', --ui for dap
                'theHamsta/nvim-dap-virtual-text', --virtual text support
                'mfussenegger/nvim-dap-python', --python-extension for DAP conf
            }
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
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({})
        end,
    },
})
