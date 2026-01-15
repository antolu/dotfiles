return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								ignore = { "*" },
								typeCheckingMode = "off",
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
}
