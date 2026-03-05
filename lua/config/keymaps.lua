vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Save with Ctrl+s
map("n", "<C-s>", ":w<CR>", { desc = "Save File" })

-- Clear search highlights with Esc
map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })

-- Better window navigation (Ctrl + h/j/k/l)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
