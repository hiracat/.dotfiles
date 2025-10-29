local cmp = require("cmp")
local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require("luasnip")

local servers = {
	"clangd",
	"nil_ls",
	"lua_ls",
	"glslls",
	"zls",
}

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			-- Add clippy lints for Rust.
			checkOnSave = true,
			allFeatures = true,
			command = "clippy",
			extraArgs = {
				"--",
				"--parallel",
				"--no-deps",
				"-Dclippy::correctness",
				"-Dclippy::complexity",
				"-Wclippy::perf",
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

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	})
end

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-p>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
})
