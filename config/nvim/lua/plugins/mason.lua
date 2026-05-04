return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {
                    ensure_installed = {
                        "clang-format",
                    },
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },
            {
                "neovim/nvim-lspconfig",
            },
        },
        opts = {
            ensure_installed = {
                "arduino_language_server",
                "awk_ls",
                "bashls",
                "clangd",
                "cmake",
                "docker_compose_language_service",
                "docker_language_server",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                "rust_analyzer",
                "tombi",
            },
        },
    },
}
