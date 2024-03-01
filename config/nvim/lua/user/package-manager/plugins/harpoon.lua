return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set("n", "<leader>pha", mark.add_file, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>phm", ui.toggle_quick_menu, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { noremap = true, silent = true })
    end
}
