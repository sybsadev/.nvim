local M = {}

function M.format_buffer()
	require("conform").format({
		bufnr = 0,
		async = false,
		timeout_ms = 5000,
		lsp_format = "fallback",
	})
end

return M
