local watchedPath = "/home/forest/.config/nvim/lua/forest/coloroverrides.lua"
local function reloadColorscheme()
	vim.cmd("so " .. watchedPath)
	vim.cmd("colorscheme catppuccin")
	print("it worked lol i hope")
	require("lualine").setup({ options = { theme = "catppuccin-mocha" } })
end

local event = vim.uv.new_fs_event()
local config = {
	recursive = true,
	watch_entry = false, -- disable watch only for changes to the directory, not its contents
	stat = true, -- fall back to stat if necessary
}
local index = 1
local function callback(err, filename, events)
	if err then
		print("error: ", err)
	end
	print("file changed: ", index, vim.uv.fs_event_getpath(event))
	index = index + 1
	vim.schedule_wrap(function()
		reloadColorscheme()
	end)() -- to immediately run the function

	vim.uv.fs_event_stop(event)
	vim.uv.fs_event_start(event, watchedPath, config, callback)
end

vim.uv.fs_event_start(event, watchedPath, config, callback)

local path = vim.uv.fs_event_getpath(event)

reloadColorscheme()
