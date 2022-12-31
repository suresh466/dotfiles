local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>tf', ':Telescope find_files<CR>', opts)
map('n', '<leader>tg', ':Telescope live_grep<CR>', opts)

local keymap = vim.keymap.set

-- remaps

--centered half page up down
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

--centered search
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

-- yank put to primary register
keymap({ 'n', 'v' }, '<leader>y', '"*y')
keymap('n', '<leader>Y', '"*Y')

keymap({ 'n', 'v' }, '<leader>p', '"*p')
keymap({ 'n', 'v' }, '<leader>P', '"*P')
