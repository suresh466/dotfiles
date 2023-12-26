vim.g.mapleader = " "

local set = vim.opt

set.termguicolors = true

set.autoindent = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4

set.number = true
set.relativenumber = true

set.scrolloff = 5

set.history = 9999
set.wildmode = "longest:list"

set.ignorecase = true
set.smartcase = true

-- mouse support only in insert mode
--set.mouse = 'i'
-- set.wrap = false
