local M = {}

function M.setup()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4

	vim.opt.termguicolors = true

	vim.opt.scrolloff = 20

	-- Persistent undo --
	vim.opt.undofile = true

	-- Smart search ?? --
	vim.opt.ignorecase = true
	vim.opt.smartcase = true

	-- Do not move text when signs appear --
	vim.opt.signcolumn = "yes"

	-- Use system clipboard --
	vim.opt.clipboard = "unnamedplus"

	-- Ask for save instead of error --
	vim.opt.confirm = true

	-- Current line highlight --
	vim.opt.cursorline = true

	vim.cmd.colorscheme("habamax")
end

return M
