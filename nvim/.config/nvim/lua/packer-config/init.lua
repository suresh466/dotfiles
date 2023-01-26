return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use({
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({})
        end,
    })
    use('ellisonleao/gruvbox.nvim')
    use('nvim-tree/nvim-tree.lua')
    use('nvim-lualine/lualine.nvim')

    --requires
    use('kyazdani42/nvim-web-devicons')
    use('nvim-lua/plenary.nvim')

    --Fuzzy finder
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.x' })

    -- Treesitter
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-refactor')
    use('nvim-treesitter/nvim-treesitter-context')
    use('https://github.com/p00f/nvim-ts-rainbow')
    use({
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    use({
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup({})
        end,
    })

    --LSP plugs
    use('neovim/nvim-lspconfig') -- Configurations collection for inbuilt LSP client

    use('hrsh7th/nvim-cmp') -- Autocompletion plugin
    use('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp
    use('hrsh7th/cmp-buffer') -- LSP source for nvim-cmp
    use('hrsh7th/cmp-path') -- LSP source for nvim-cmp
    use('hrsh7th/cmp-cmdline') -- LSP source for nvim-cmp

    use('L3MON4D3/LuaSnip') -- Snippets plugin
    use('saadparwaiz1/cmp_luasnip') -- Snippets source for nvim-cmp

    use('jose-elias-alvarez/null-ls.nvim') -- provides lsp hooks
    use('folke/neodev.nvim') -- for sumneko_lua lsp server config
    use('onsails/lspkind.nvim') -- for vs-code like pictograms in builtin nvim lsp

    -- Debugging plugs
    use({
        'mfussenegger/nvim-dap',
        requires = {
            'rcarriga/nvim-dap-ui', --ui for dap
            'theHamsta/nvim-dap-virtual-text', --virtual text support
            'mfussenegger/nvim-dap-python', --python-extension for DAP conf
        },
    })
    -- Test framework
    use({
        'nvim-neotest/neotest',
        requires = {
            'nvim-neotest/neotest-python',
        },
    })
    -- commentary
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({})
        end,
    })
end)
