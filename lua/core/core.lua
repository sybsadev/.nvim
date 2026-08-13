local M = {}

local plugins = {
	"mini.pairs",
	"mini.surround",
	"plugins.which-key",
	"plugins.oil",
	"plugins.treesitter",
	"plugins.blink",
	"plugins.lsp",
	"plugins.telescope",
	"plugins.multi-cursor",
}

local configs = {
	"config.php",
	"config.ide",
}

local core = {
	"core.opts",
	"core.keymaps",
}

local function mod_setup(list)
	for _, value in ipairs(list) do
		require(value).setup()
	end
end

function M.download()
	vim.pack.add({
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/stevearc/conform.nvim",
		"https://github.com/mfussenegger/nvim-lint",
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/folke/trouble.nvim",
		"https://github.com/folke/todo-comments.nvim",
		"https://github.com/nvim-lualine/lualine.nvim",
		"https://github.com/lewis6991/gitsigns.nvim",
		"https://github.com/stevearc/oil.nvim",
		"https://github.com/folke/which-key.nvim",
		"https://github.com/nvim-mini/mini.nvim",
		"https://github.com/jake-stewart/multicursor.nvim",
		{
			src = "https://github.com/saghen/blink.lib",
			version = "main",
		},
		{
			src = "https://github.com/saghen/blink.cmp",
			version = "main",
		},
	})
end

function M.init()
	mod_setup(core)
	mod_setup(plugins)
	mod_setup(configs)
end

return M
