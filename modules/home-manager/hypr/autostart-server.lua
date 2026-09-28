-------------------
---- AUTOSTART ----
-------------------

-- server autostart. the graphical session exists for occasional admin work over
-- wayvnc, so the desktop apps (spotify, discord, steam) are deliberately omitted
-- and only the session plumbing is started.

hl.on("hyprland.start", function()
	hl.exec_cmd("dex -a -e Hyprland")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hypridle")
end)
