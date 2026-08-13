local M = {}

local root_markers = {
	"phpstan.neon",
	"phpstan.neon.dist",
	"artisan",
	"composer.json",
}

local function project_root(bufnr)
	return vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
end

function M.setup()
	-- PHP LSP
	vim.lsp.enable("intelephense")

	-- Laravel-specific LSP, если бинарник установлен
	if vim.fn.executable("laravel-ls") == 1 then
		vim.lsp.enable("laravel_ls")
	end

	-- Formatters
	local conform = require("conform")
	local conform_util = require("conform.util")

	conform.setup({
		formatters_by_ft = {
			php = { "pint" },
			blade = { "blade-formatter" },
		},

		formatters = {
			["blade-formatter"] = {
				command = conform_util.find_executable({
					"node_modules/.bin/blade-formatter",
				}, "blade-formatter"),
			},
		},

		format_on_save = function(bufnr)
			local ft = vim.bo[bufnr].filetype

			if ft == "php" or ft == "blade" then
				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
				}
			end
		end,
	})

	-- Larastan / PHPStan
	local lint = require("lint")

	lint.linters_by_ft.php = {
		"phpstan",
	}

	local lint_group = vim.api.nvim_create_augroup("php-lint", {
		clear = true,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lint_group,
		pattern = "*.php",
		callback = function(args)
			-- Blade отдельно не прогоняем через PHPStan
			if vim.bo[args.buf].filetype ~= "php" then
				return
			end

			local root = project_root(args.buf)
			local phpstan = vim.fs.joinpath(
				root,
				"vendor",
				"bin",
				"phpstan"
			)

			if vim.uv.fs_stat(phpstan) then
				lint.try_lint(nil, {
					cwd = root,
				})
			end
		end,
	})

	vim.keymap.set("n", "<leader>ll", function()
		lint.try_lint("phpstan", {
			cwd = project_root(0),
		})
	end, {
		desc = "Run PHPStan",
	})
end

return M
