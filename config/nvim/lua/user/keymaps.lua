vim.g.mapleader = " "

-- Neo tree configured in ../../after/plugin/neotree.lua

-- Normal mode movements
--vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true }) -- delete white space at the end of line
--vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true }) -- scroll down and position current line in the center of the screen
--vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true }) -- scroll up and position current line in the center of the screen
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true }) -- go to next search result, position line in the middle of the screen and neter visual mode 
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true }) -- go to previous search result, position line in the middle of the screen and neter visual mode

-- Visual mode movements
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true }) -- move line under cursor down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true }) -- move line under cursor up
