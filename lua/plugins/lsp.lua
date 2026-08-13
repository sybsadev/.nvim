local M = {}


function M.setup()
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
end

return M
