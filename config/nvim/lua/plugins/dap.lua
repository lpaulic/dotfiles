return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})
            vim.keymap.set("n", "<Leader>dn", dap.step_over, {})
            vim.keymap.set("n", "<Leader>ds", dap.step_into, {})
            vim.keymap.set("n", "<Leader>do", dap.step_out, {})
            vim.keymap.set("n", "<Leader>db", dap.step_back, {})
            vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
            vim.keymap.set("n", "<Leader>dP", dap.pause, {})
            vim.keymap.set("n", "<Leader>dS", dap.stop, {})
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
            ensure_installed = {
                "codelldb",
                "debugpy",
            },
        },
    },
}
