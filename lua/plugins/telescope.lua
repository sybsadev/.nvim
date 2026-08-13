

local M = {}

function M.setup()
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
end

return M
