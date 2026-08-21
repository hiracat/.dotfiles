require("conform").setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		zsh = { "shfmt" },
		lua = { "stylua" },
		cpp = { "clang_format" },
		glsl = { "clang_format" },
		shaderslang = { lsp_format = "prefer" },
		rust = { "rustfmt" },
		nix = { "nixpkgs_fmt" },
		json = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
	},
})
