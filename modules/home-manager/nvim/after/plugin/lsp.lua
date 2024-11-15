local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_zero = require("lsp-zero")
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

lspconfig.clangd.setup({})
lspconfig.lua_ls.setup({})
lspconfig.cmake.setup({})
lspconfig.nil_ls.setup({})

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
	}),
})
