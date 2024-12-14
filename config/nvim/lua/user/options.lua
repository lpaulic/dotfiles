local options = {
	backup = false, -- do not create a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space for the neovim command line for displaying messages
	complete = "", -- clear because nvim-cmp is used
	completeopt = {}, -- mosly just for cmp
	conceallevel = 0, -- so taht `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	incsearch = true, -- search as you type
	hlsearch = true, -- highlight all search matches on previous search
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mous to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- do not display the current neovim mode, have different means to that
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go bellow current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- do not create a swap file
	termguicolors = true, -- set terminal gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in miliseconds)
	undofile = true, -- enable persistant undo
	undodir = os.getenv("HOME") .. "/.nvim/undodir", -- directory used for storing data for undo
	updatetime = 50, -- faster completition (4000ms default)
	writebackup = false, -- if a file is being edited by another program
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 4 spaces for a tab
	softtabstop = 4, -- characters the cursor moves when tab is pressed
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width (4 default)
	signcolumn = "yes", -- always show the sign column
	wrap = false, -- do not break a line
	scrolloff = 8, -- number of lines visible around the cursor line
	guifont = "Fira Code Nerd Font:10", -- font used in graphical neovim applications
	--colorcolumn = "120",                                -- color the column to know the line width
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end
