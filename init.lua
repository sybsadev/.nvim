local helpers = require("config.helpers")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- Plugins --
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

-- Treesitter --
require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		"lua",
		"php",
		"blade",
		"html",
		"css",
		"javascript",
	},
	callback = function(args)
		local ok, error_message = pcall(
			vim.treesitter.start,
			args.buf
		)
		if not ok then
			vim.notify(
				"Tree-sitter: " .. error_message,
				vim.log.levels.WARN
			)
		end
	end,
})

-- PHP --
require("config.php").setup()

-- BLINK --
vim.pack.add({
	{
		src = "https://github.com/saghen/blink.lib",
		version = "main",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "main",
	},
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		['<Tab>'] = { function(cmp) return cmp.select_and_accept({ force = true }) end },
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
		},
		ghost_text = {
			enabled = true,
		},
	},

	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
	},

	fuzzy = {
		implementation = "lua",
	},

	signature = {
		enabled = true,
	},
})

-- LSP --
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = {
					"vim",
				},
			},

			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

vim.lsp.enable("lua_ls")

-- Telescope --
require("telescope").setup({})

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files, {
	desc = "Find files",
})

vim.keymap.set("n", "<leader>fg", telescope.live_grep, {
	desc = "Live grep",
})

vim.keymap.set("n", "<leader>fb", telescope.buffers, {
	desc = "Buffers",
})

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
vim.keymap.set("n", "<leader>fo", helpers.format_buffer, {
	desc = "Format buffer",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua",
	callback = helpers.format_bjffer
})
