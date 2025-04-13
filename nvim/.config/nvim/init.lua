require("config.settings")
require("lazy-config")
require("mappings.general") -- after lazy because it uses lazy utils indirectly

require("avante_lib").load()

require("treesitter-config")
require("lsp-config.language-servers")
require("lsp-config.nvim-cmp")
require("luasnip-config")

require("dap-config")
--require('neotest-config')
require("telescope-config")

require("lint-config")
require("conform-config")
