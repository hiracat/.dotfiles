require("conform").setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		zsh = { "shfmt" },
		lua = { "stylua" },
		cpp = { "clang_format" },
		glsl = { "clang_format" },
		rust = { "rustfmt" },
		nix = { "nixpkgs_fmt" },
	},
	format_on_save = {
		timeout_ms = 500,
	},
})
