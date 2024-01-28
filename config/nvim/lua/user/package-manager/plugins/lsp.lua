return {
    {
        -- installs LSPs
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        -- glue logic that connects mason and nvim-lspconfig
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",           -- lua
                    "bashls",           -- bash
                    "clangd",           -- c
                    "rust_analyzer",    -- rust
                }
            })
        end
    },
    {
        -- LSP client in nvim
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.rust_analyzer.setup({})

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
