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
k("t", "<Esc>", "<C-\\><C-n>", opts)

-- text editing stuff
k("n", "<C-d>", "<C-d>zz", opts)
k("n", "<C-u>", "<C-u>zz", opts)

k("n", "n", "nzzzv", opts)
k("n", "N", "Nzzzv", opts)

k("n", "J", "mzJ`z", opts)

-- window stuff
-- ###########

k("n", "<A-h>", "<C-w>h", opts)
k("n", "<A-j>", "<C-w>j", opts)
k("n", "<A-k>", "<C-w>k", opts)
k("n", "<A-l>", "<C-w>l", opts)

k("n", "<A-v>", "<C-w>v", opts)

-- clipboard stuff
-- ##############

k("x", "<leader>p", [["_dP]])
k({ "n", "v" }, "<leader>y", [["+y]], opts)
k("n", "<leader>Y", [["+Y]], opts)

k({ "n", "v" }, "<leader>d", [["_d]], opts)

-- quick fix list
-- #######################

k("n", "<C-j>", ":cnext<CR>zz", opts)
k("n", "<C-k>", ":cprev<CR>zz", opts)
k("n", "<C-q>", ":cclose<CR>zz", opts)

-- Plugin Remaps
-- #############

-- Telescope
local telescope = require("telescope.builtin")

k("n", "<leader>fd", telescope.find_files, opts)
k("n", "<leader>fs", telescope.live_grep, opts)
k("n", "<leader>fo", telescope.buffers, opts)
k("n", "<leader>fh", telescope.help_tags, opts)

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
			n = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
})

-- Dap
k("n", "<leader>dut", ":lua require'dapui'.toggle()<CR>", opts)
k("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", opts) -- F9 matches VS Code / JetBrains convention
k("n", "<F5>", ":lua require'dap'.continue()<CR>", opts) -- F5 = run/continue (standard)
k("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts) -- F11 = step into (standard)
k("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts) -- F10 = step over (standard)

k("n", "<A-m>", ':lua require("dap.ui.widgets").hover()<CR>', { noremap = true }) -- fixed from broken <A>k

-- Harpoon2
local harpoon = require("harpoon")
harpoon:setup()

k("n", "<leader>mf", function()
	harpoon:list():add()
end)
k("n", "<A-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

k("n", "<A-f>", function()
	harpoon:list():select(1)
end)
k("n", "<A-d>", function()
	harpoon:list():select(2)
end)
k("n", "<A-s>", function()
	harpoon:list():select(3)
end)
k("n", "<A-a>", function()
	harpoon:list():select(4)
end)

-- Fugitive
-- All git ops live under <leader>g
k("n", "<leader>gg", vim.cmd.Git, opts) -- open fugitive status (main panel)
k("n", "<leader>gp", "<cmd>Git push<CR>", opts) -- push
k("n", "<leader>gl", "<cmd>Git pull<CR>", opts) -- pull
k("n", "<leader>gb", "<cmd>Git blame<CR>", opts) -- blame current file
k("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", opts) -- diff current file vs HEAD
k("n", "<leader>gc", "<cmd>Git commit<CR>", opts) -- commit
k("n", "<leader>gL", "<cmd>Git log --oneline<CR>", opts) -- quick log

-- LSP
-- ##

-- Code actions
k({ "n", "i" }, "<C-s>", function()
	vim.lsp.buf.code_action({ apply = true })
end)

-- Diagnostics toggle
vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
	local current_value = vim.diagnostic.config().virtual_text
	if current_value then
		vim.diagnostic.config({ virtual_text = false })
	else
		vim.diagnostic.config({ virtual_text = true })
	end
end, {})

k("n", "<leader>ii", ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>', opts)

-- Hover / docs
k("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

-- Go-to navigation (standard conventions)
k("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
k("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
k("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
k("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
k("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { noremap = true })
k("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

-- Refactor
k("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

-- Diagnostics
k("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
k("n", "[d", "<cmd>lua vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })<cr>")
k("n", "]d", "<cmd>lua vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })<cr>")
k("n", "[f", "<cmd>lua vim.diagnostic.jump({ count = -1 })<cr>")
k("n", "]f", "<cmd>lua vim.diagnostic.jump({ count = 1 })<cr>")
