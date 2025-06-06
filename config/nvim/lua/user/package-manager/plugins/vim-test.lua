return {
    "vim-test/vim-test",
    depencencies = {
        "preservim/vimux"
    },
    vim.keymap.set("n", "<leader>ptt", ":TestNearest<CR>"),
    vim.keymap.set("n", "<leader>ptT", ":TestFile<CR>"),
    vim.keymap.set("n", "<leader>pta", ":TestSuite<CR>"),
    vim.keymap.set("n", "<leader>ptl", ":TestLast<CR>"),
    vim.keymap.set("n", "<leader>ptg", ":TestVisit<CR>"),
    vim.cmd("let test#strategy = 'vimux'")
}
