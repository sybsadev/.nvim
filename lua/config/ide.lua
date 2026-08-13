local M = {}

local function lsp_clients()
	local clients = vim.lsp.get_clients({
		bufnr = 0
	})

	if #clients == 0 then
		return ""
	end

	local names = {}

	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	table.sort(names)

	return "LSP: " .. table.concat(names, ", ")
end

function M.setup()
	local telescope = require("telescope.builtin")

	vim.keymap.set("n", "gd", telescope.lsp_definitions, {
		desc = "Go to defenition"
	})

	vim.keymap.set("n", "gr", telescope.lsp_references, {
		desc = "Go to reference",
	})

	vim.keymap.set("n", "grr", telescope.lsp_references, {
		desc = "Go to reference",
	})

	vim.keymap.set("n", "gri", telescope.lsp_implementations, {
		desc = "Go to implementation",
	})

	vim.keymap.set("n", "grt", telescope.lsp_type_definitions, {
		desc = "Go to type definition",
	})

	vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols, {
		desc = "Document symbols",
	})

	-- Diagnostics --
	vim.diagnostic.config({
		underline = true,
		signs = true,
		severity_sort = true,
		update_in_insert = false,

		virtual_text = {
			spacing = 2,
			prefix = "●",
		},

		float = {
			border = "rounded",
			source = true,
		},
	})

	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({
			count = 1,
			float = true,
		})
	end, {
		desc = "Next diagnostic",
	})

	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({
			count = -1,
			float = true,
		})
	end, {
		desc = "Previous diagnostic",
	})

	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
		desc = "Show diagnostic",
	})

	-- Trouble --
	require("trouble").setup({})

	vim.keymap.set(
		"n",
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle focus=true<CR>",
		{ desc = "Project diagnostics" }
	)

	vim.keymap.set(
		"n",
		"<leader>xb",
		"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>",
		{ desc = "Buffer diagnostics" }
	)

	vim.keymap.set(
		"n",
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=true win.position=right<CR>",
		{ desc = "Document symbols" }
	)

	-- TODO --
	require("todo-comments").setup({})

	vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", {
		desc = "Find TODO"
	})

	-- Git signs --
	require("gitsigns").setup({})

-- Нижняя строка
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,

			-- Работает без Nerd Font
			icons_enabled = false,
			component_separators = "|",
			section_separators = "",
		},

		sections = {
			lualine_a = {
				"mode",
			},

			lualine_b = {
				"branch",
				{
					"diff",
					symbols = {
						added = "+",
						modified = "~",
						removed = "-",
					},
				},
			},

			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = {
						modified = " [+]",
						readonly = " [RO]",
						unnamed = "[No name]",
						newfile = " [New]",
					},
				},
			},

			lualine_x = {
				{
					"diagnostics",
					sources = {
						"nvim_diagnostic",
					},
					symbols = {
						error = "E:",
						warn = "W:",
						info = "I:",
						hint = "H:",
					},
				},
				lsp_clients,
				"filetype",
			},

			lualine_y = {
				"progress",
			},

			lualine_z = {
				"location",
			},
		},
	})
end

return M
