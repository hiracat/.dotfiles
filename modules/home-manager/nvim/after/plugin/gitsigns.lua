require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		-- hunk navigation
		map("n", "]h", function()
			gs.nav_hunk("next")
		end, "Next hunk")
		map("n", "[h", function()
			gs.nav_hunk("prev")
		end, "Prev hunk")

		-- stage / reset
		map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected lines")
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selected lines")
		map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

		-- inspect
		map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
	end,
})
