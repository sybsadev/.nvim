
local M = {}

function M.setup()
	local which_key = require("which-key")

which_key.setup({
	delay = 50,
})

which_key.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>x", group = "diagnostics" },
	{ "<leader>s", group = "Splits" },
})
end

return M
