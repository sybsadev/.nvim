local M = {}

function M.setup()
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
end

return M
