local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

	-- colorschemes
	{ "EdenEast/nightfox.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "shaunsingh/nord.nvim", name = "nord", priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine" },

	-- apearance
	{ "mfussenegger/nvim-dap" },
	{ "theprimeagen/harpoon" },
	{ "xiyaowong/transparent.nvim", lazy = false },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "eandrju/cellular-automaton.nvim" },

	-- tools
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "tpope/vim-commentary" },
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "mhartington/formatter.nvim" },
	{ "ThePrimeagen/vim-be-good" },

	-- long things
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		-- LSP Support
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
			},
		},
		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{ "L3MON4D3/LuaSnip" },
			},
		},
	},
}
local opts = {}
require("lazy").setup(plugins, opts)
