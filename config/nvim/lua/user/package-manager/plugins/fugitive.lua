return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>pgs", vim.cmd.Git)
    end
}
