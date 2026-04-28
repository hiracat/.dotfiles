vim.filetype.add({
	extension = {
		rasi = "rasi",
		glsl = "glsl",
		vert = "glsl",
		frag = "glsl",
		tesc = "glsl",
		tese = "glsl",
		geom = "glsl",
		comp = "glsl",
	},
	pattern = {
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/kitty/*.conf"] = "bash",
		[".*/hypr/.*%.conf"] = "hyprlang",
	},
})
