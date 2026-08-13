local M = {}

function M.setup()
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
end

return M
