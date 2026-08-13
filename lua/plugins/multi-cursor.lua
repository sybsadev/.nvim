local M = {}

function M.setup()
	local mc = require("multicursor-nvim")

	mc.setup()

	local map = vim.keymap.set

	-- Add cursor below or above --
	map({ "n", "x" }, "<leader>mj", function()
		mc.lineAddCursor(1)
	end, { desc = "Cursor below" })

	map({ "n", "x" }, "<leader>mk", function()
		mc.lineAddCursor(-1)
	end, { desc = "Cursor above" })

	-- Add next match --
	map({ "n", "x" }, "<leader>mn", function()
		mc.matchAddCursor(1)
	end, { desc = "Add next match" })

	-- Skip next match --
	map({ "n", "x" }, "<leader>ms", function()
		mc.matchSkipCursor(1)
	end, { desc = "Skip next match" })

	-- All matches --
	map({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors, {
		desc = "Add all matches",
	})

	-- Search multicursor --
	map("n", "<leader>m/", function()
		mc.searchAddCursor(1)
	end, { desc = "Add next search result" })

	map("n", "<leader>m*", mc.searchAllAddCursors, {
		desc = "Add all search results",
	})

	mc.addKeymapLayer(function(layer)
		layer("n", "<Esc>", function()
			if mc.cursorsEnabled() then
				mc.clearCursors()
			else
				mc.enableCursors()
			end
		end)
	end)
end

return M
