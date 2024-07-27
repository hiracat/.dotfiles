local k = vim.keymap.set
vim.g.mapleader = " "
vim.g.localmapleader = " "

local opts = {
	noremap = true,
	silent = true,
}

-- Native functionality remaps
--############################

-- file and buffer stuff
k("n", "<leader>fn", ":Ex<CR>", opts)

k("n", "<Tab>", ":bn<CR>", opts)
k("n", "<leader>x", ":w<cr>:bd<CR>", opts)
k("t", "<Esc>", "<C-\\><C-n>", opts)

-- terminal stuff
k("n", "<leader>t", ":w<CR>:term<CR>i", opts)
k("t", ":q<cr>", "<C-\\><C-n>:bd!<CR>", opts)

-- text editing stuff
k("v", "J", ":m '>+1<CR>gv=gv", opts) --allows you to move highlighted lines around
k("v", "K", ":m '<-2<CR>gv=gv", opts)

k("n", "<C-d>", "<C-d>zz", opts) --keeps mouse in hte same position while doing half page jumping
k("n", "<C-u>", "<C-u>zz", opts)

k("n", "n", "nzzzv", opts) --when searching it keeps the cursor in the middle
k("n", "N", "Nzzzv", opts)

k("n", "J", "mzJ`z", opts) --keeps the mose in the same place and appends the next line onto the current like with a space

-- fix quotes stuff
-- ###########
k("i", "(", "()<ESC>i", opts)
k("i", "[", "[]<ESC>i", opts)
k("i", "{", "{}<ESC>i", opts)
k("i", '"', '""<ESC>i', opts)
k("i", "'", "''<ESC>i", opts)

-- window stuff
-- ###########

k("n", "<A-h>", "<C-w>h", opts)
k("n", "<A-j>", "<C-w>j", opts)
k("n", "<A-k>", "<C-w>k", opts)
k("n", "<A-l>", "<C-w>l", opts)

-- clipboard stuff
-- ##############

k("x", "<leader>p", [["_dP]]) --allows you to paste over a highlighted word without the highlighted word replacing the current word
k({ "n", "v" }, "<leader>y", [["+y]], opts) --allows cpying into the system register with leader y
k("n", "<leader>Y", [["+Y]], opts)

k({ "n", "v" }, "<leader>d", [["_d]], opts) --allows more deleting to void regiest in noremal and visual

-- external stuff
-- ##############
k("n", "<leader>mx", ":!chmod +x %<CR>", opts) --make executable

-- stuff i dont understand
-- #######################

-- k("n", "Q", "<nop>", opts) --disables Q which does somethign wierd

k("n", "<C-j>", ":cnext<CR>zz", opts) --quick fix list navigation
k("n", "<C-k>", ":cprev<CR>zz", opts)

k("n", "<C-q>", ":cclose<CR>zz", opts)

k("n", "<leader>j", ":lnext<CR>zz", opts)
k("n", "<leader>k", ":lprev<CR>zz", opts)

-- Plugin Remaps
-- #############

-- Telescope
local builtin = require("telescope.builtin")

k("n", "<leader>ff", function()
	builtin.find_files({ hidden = true })
end, {}, opts) --file find

k("n", "<leader>fs", function()
	builtin.live_grep({ hidden = true })
end, {}, opts) --file search

k("n", "<leader>fo", function()
	builtin.buffers({ hidden = true })
end, {}, opts) --file open

k("n", "<leader>fh", function()
	builtin.help_tags({ hidden = true })
end, {}, opts) --file help

-- Dap
k("n", "<leader>dut", ":lua require'dapui'.toggle()<CR>", opts) --dap ui toggle
k("n", "<F5>", ":lua require'dap'.toggle_breakpoint()<CR>", opts) --dap toggle breakpoint
k("n", "<F6>", ":lua require'dap'.continue()<CR>", opts) --dap continue
k("n", "<F7>", ":lua require'dap'.step_into()<CR>", opts) --dap setp into
k("n", "<F8>", ":lua require'dap'.step_over()<CR>", opts) --dap set over

k("n", "<A>k", ':lua require("dap.ui.widgets").hover()<CR>', { noremap = true })

-- Harpoon.nvim
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>mf", mark.add_file)
vim.keymap.set("n", "<A-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-f>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<A-d>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<A-s>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<A-a>", function()
	ui.nav_file(4)
end)

-- Formatter.nvim
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- Fugitive.nvim
k("n", "<leader>gs", vim.cmd.Git, opts) --vim fugitive

-- Undotree
k("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

-- Cellular automation.nvim

-- LSP
k({ "n", "i" }, "<C-s>", function()
	vim.lsp.buf.code_action({ apply = true })
end)

k("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

k("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
k("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
k("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
k("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
k("n", "ge", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
k("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

k("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

k("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
k("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
k("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

k({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
