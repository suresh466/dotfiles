local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>p', '"*p', opts)
map('n', '<leader>y', '"*y', opts)
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>l', ':so<CR>', opts)
map('n', '<leader>tf', ':Telescope find_files<CR>', opts)
map('n', '<leader>tg', ':Telescope live_grep<CR>', opts)
