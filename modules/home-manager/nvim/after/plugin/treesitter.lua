require("nvim-treesitter.install").install({ "c", "lua", "vimdoc", "cpp", "rust" })
vim.treesitter.language.register("slang", "shaderslang")

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
