vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("blink.cmp")
			end
			vim.cmd("BlinkCmp build --release")
		end
	end,
})

local plugins = {
	-- Colorschemes
	{ src = "https://github.com/EdenEast/nightfox.nvim" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/shaunsingh/nord.nvim", name = "nord" },
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/GnRlLeclerc/dynamic-base16.nvim" },

	-- Appearance / UI
	{ src = "https://github.com/xiyaowong/transparent.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/eandrju/cellular-automaton.nvim" },
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },

	-- Navigation / Tools
	{ src = "https://github.com/theprimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/ThePrimeagen/vim-be-good" },

	-- Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-dap.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- DAP (Debug Adapter Protocol)
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },

	-- Folke plugins
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },

	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- Completion
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
}

vim.pack.add(plugins)
