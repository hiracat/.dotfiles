{ config, pkgs, ... }: {
  home.file = {
    ".config/dunst/dunstrc" = with config.scheme; {
      enable = true;
      text = ''
            [global]
            follow = mouse
            width = 300
            height = 200
            origin = top-right
            offset = 20x20
            notification_limit = 5
            ### Progress bar ###
            progress_bar = true
            progress_bar_height = 10
            progress_bar_frame_width = 1
            progress_bar_min_width = 150
            progress_bar_max_width = 300
            progress_bar_corner_radius = 10
            progress_bar_corners = all
            icon_corner_radius = 4

            icon_corners = all
            indicate_hidden = yes

            separator_height = 3

            padding = 8
            horizontal_padding = 8

            text_icon_padding = 0

            frame_width = 3

            frame_color = "#${base0E}"
            separator_color = frame

            sort = yes

            font = Fira Sans 10
            line_height = 2
            markup = full
            #   %a  appname
            #   %s  summary
            #   %b  body
            #   %i  iconname (including its path)
            #   %I  iconname (without its path)
            #   %p  progress value if set ([  0%] to [100%]) or nothing
            #   %n  progress value if set without any extra characters
            #   %%  Literal %
            # Markup is allowed
            format = "<b>%s</b>\n%b"
            alignment = left
            vertical_alignment = center
            show_age_threshold = 60
            ellipsize = middle
            ignore_newline = no
            stack_duplicates = true
            hide_duplicate_count = false
            show_indicators = yes
            ### Icons ###
            # Recursive icon lookup. You can set a single theme, instead of having to
            # define all lookup paths.
            enable_recursive_icon_lookup = true
            icon_theme = candy-icons
            icon_position = left
            min_icon_size = 32
            max_icon_size = 64
            sticky_history = yes
            history_length = 40
            # dmenu path.
            dmenu = ${pkgs.rofi}/bin/rofi -show dmenu
            # Browser for opening urls in context menu.
            browser = /usr/bin/xdg-open
            # Always run rule-defined scripts, even if the notification is suppressed
            always_run_script = true
            corner_radius = 10
            corners = all
            ignore_dbusclose = false
            force_xwayland = false
            mouse_left_click = close_current
            mouse_middle_click = do_action, close_current
            mouse_right_click = close_all
        [urgency_low]
            background = "#${base00}"
            foreground = "#${base05}"
            timeout = 10
        [urgency_normal]
            background = "#${base00}"
            foreground = "#${base05}"
            timeout = 10
            override_pause_level = 30
        [urgency_critical]
            background = "#${base08}"
            foreground = "#${base05}"
            frame_color = "#${base09}"
            timeout = 0
            override_pause_level = 60
      '';
    };
  };
}
