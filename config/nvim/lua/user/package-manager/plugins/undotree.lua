return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>pu', vim.cmd.UndotreeToggle, { noremap = true, silent = true })
    end
}
