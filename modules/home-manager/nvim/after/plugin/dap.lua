require("dapui").setup()

local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}

local codelldb_path = os.getenv("CODELLDB_PATH")

dap.adapters.lldb = {
	type = "executable",
	command = codelldb_path,

	-- On windows you may have to uncomment this:
	-- detached = false,
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = true,
		initCommands = {
			"command script import /home/forest/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_lookup.py",
			"command script import /home/forest/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_providers.py",
			"command script import /home/forest/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc/rust_types.py",
			"command source /home/forest/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc/lldb_commands",
			"type category enable Rust",
		},
	},
}
