return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- lua
                null_ls.builtins.formatting.stylua,
                -- bash
                null_ls.builtins.formatting.beautysh,
                null_ls.builtins.diagnostics.shellcheck,
                -- c
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.diagnostics.clangd,
            },
        })

        vim.keymap.set("n", "<leader>pl", vim.lsp.buf.format, {})
    end,
}
