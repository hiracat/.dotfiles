local ok, blink = pcall(require, "blink.cmp")
local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			check = {
				command = "clippy",
				extraArgs = {
					"--no-deps",
					"--",
					"-Dclippy::correctness",
					"-Dclippy::complexity",
					"-Wclippy::perf",
				},
			},
			procMacro = {
				enable = true,
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
		},
	},
})

vim.lsp.enable({
	"clangd",
	"nil_ls",
	"lua_ls",
	"zls",
	"glslls",
	"rust_analyzer",
})
