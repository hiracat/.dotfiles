local rainbow = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
require("snacks").setup({
	picker = { enabled = true },
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	words = { enabled = true },
	input = { enabled = true },
	image = { enabled = true },
	explorer = { enabled = true, replace_netrw = true },
	statuscolumn = { enabled = true },
	indent = {
		enabled = true,
		indent = { hl = rainbow },
		scope = { hl = "IndentBlanklineScope" },
		animate = { enabled = false },
	},
})

local function set_indent_hl()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	vim.api.nvim_set_hl(0, "IndentBlanklineScope", { fg = "#FFFFFF" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_indent_hl })
set_indent_hl()
