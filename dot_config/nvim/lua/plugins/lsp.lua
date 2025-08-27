return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					settings = {
						python = {
							analysis = {
								ignore = { "*" },
								typeCheckingMode = "off",
								reportUnknownParameterType = "off",
							},
						},
					},
				},
				ruff = {
					settings = {},
				},
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources, { nls.builtins.formatting.mypy })
		end,
	},
}
