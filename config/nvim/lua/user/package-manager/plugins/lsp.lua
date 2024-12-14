return {
    {
        -- installs LSPs
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end
    },
    {
        -- glue logic that connects mason and nvim-lspconfig
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        }
    },
    {
        -- LSP client in nvim
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.bashls.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities
            })
            lspconfig.remakr_ls.setup({
                capabilities = capabilities
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
            vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true })
        end
    }
}
