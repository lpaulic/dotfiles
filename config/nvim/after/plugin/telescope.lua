local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ptf', builtin.find_files, {})
vim.keymap.set('n', '<leadr>ptg', builtin.git_files, {})
vim.keymap.set('n', '<leader>pts', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
