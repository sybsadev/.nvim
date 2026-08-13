local M = {}

function M.setup()
	-- Splits --
	vim.keymap.set("n", "<leader>ss", ":split<CR>", {
		desc = "Horizontal split",
	})

	vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", {
		desc = "Vertical split",
	})

	-- Splits movement --
	vim.keymap.set("n", "<C-h>", "<C-w>h", {
		desc = "Move to the left window",
	})

	vim.keymap.set("n", "<C-l>", "<C-w>l", {
		desc = "Move to the right window",
	})

	vim.keymap.set("n", "<C-k>", "<C-w>k", {
		desc = "Move to the window above",
	})

	vim.keymap.set("n", "<C-j>", "<C-w>j", {
		desc = "Move to the window below",
	})

	-- Close shorcut --
	vim.keymap.set("n", "<leader>q", ":q<Cr>", {
		desc = "Close shorcut",
	})

	-- Formater --
	local helpers = require("config.helpers")

	vim.keymap.set("n", "<leader>fo", helpers.format_buffer, {
		desc = "Format buffer",
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.lua",
		callback = helpers.format_buffer
	})
end

return M
