require("transparent").setup({
	groups = { -- table: default groups
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLineNr",
		"EndOfBuffer",
	},
	extra_groups = {}, -- table: additional groups that should be cleared
	exclude_groups = {}, -- table: groups you don't want to clear
})

-- setup must be called before loading
require("nightfox").setup()
vim.opt.termguicolors = true

require("colorizer").setup({
	filetypes = { "*" },
	user_default_options = {
		RGB = false, -- #RGB hex codes
		RRGGBB = true, -- #hex codes
		names = false, -- "Name" codes like or blue
		RRGGBBAA = true, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions
		css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "background", -- Set the display mode.
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = true, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
		virtualtext = "■",
		-- update color values even if buffer is not focused
		-- example use: cmp_menu, cmp_docs
		always_update = true,
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
})
