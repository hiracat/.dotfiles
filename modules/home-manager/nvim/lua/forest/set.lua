vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.have_nerd_font = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.showmode = false

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.inccommand = "split"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.timeoutlen = 500

vim.opt.colorcolumn = "130"
vim.opt.mouse = "a"

vim.opt.shell = "/run/current-system/sw/bin/zsh"
vim.o.ignorecase = true

vim.opt.list = true

vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
vim.opt.autoread = true

vim.opt.foldmethod = "manual" -- Set folding method to manual
vim.opt.foldenable = true -- Enable folding
vim.opt.viewoptions = "folds" -- Save folds in views

-- Autocommands to save and restore folds
vim.api.nvim_create_augroup("SaveFolds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = "SaveFolds",
	pattern = "*",
	command = "silent! mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "SaveFolds",
	pattern = "*",
	command = "silent! loadview",
})

vim.cmd("colorscheme catppuccin-mocha")
