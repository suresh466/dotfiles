--require('packer-config')
require('settings')
require('mappings')
require('lazy-config')

require('colorschemes-config.gruvbox')
require('nvim-tree-config')
require('lualine-config')

require('mason-config.mason')

require('treesitter-config')

require('lsp-config.language-servers')
--require('lsp-config.null-ls')
require('lsp-config.nvim-cmp')

require('luasnip-config')

require('dap-config')
--require('neotest-config')

