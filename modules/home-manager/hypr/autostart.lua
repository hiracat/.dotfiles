-------------------
---- AUTOSTART ----
-------------------

-- full desktop autostart, used on desktop and laptop.

hl.on("hyprland.start", function()
	hl.exec_cmd("dex -a -e Hyprland")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")
	hl.exec_cmd("[workspace special:spotify silent] spotify")
	hl.exec_cmd("[workspace special:discord silent] discord")
	hl.exec_cmd("steam -silent")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hypridle")
end)
