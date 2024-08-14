{ userSettings, config, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "no-rc"; # disable features if desired here
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    font.name = userSettings.font;
    font.size = 12;
    font.package = userSettings.fontPkg;
    extraConfig = ''
      include theme.conf
    '';
  };
  home.file = {
    ".config/kitty/theme.conf" = {
      enable = true;
      text = with config.scheme; ''
        foreground              #${base05}
        background              #${base00}

        selection_foreground    #${base05}
        selection_background    #${base02}

        # Cursor colors
        cursor                  #${base05}
        cursor_text_color       #${base00}

        # URL underline color when hovering with mouse
        url_color               #${base04}

        # Kitty window border colors
        active_border_color     #${base0E}
        inactive_border_color   #${base03}
        bell_border_color       #${base0A}

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        active_tab_foreground   #${base01}
        active_tab_background   #${base0E}
        inactive_tab_foreground #${base05}
        inactive_tab_background #${base01}
        tab_bar_background      #${base01}

        # Colors for marks (marked text in the terminal)
        mark1_foreground #${base01}
        mark1_background #${base08}
        mark2_foreground #${base01}
        mark2_background #${base09}
        mark3_foreground #${base01}
        mark3_background #${base0A}

        # The 16 terminal colors

        # black
        color0 #${base02}
        color8 #${base03}

        # red
        color1 #${base08}
        color9 #${base08}

        # green
        color2  #${base0B}
        color10 #${base0B}

        # yellow
        color3  #${base0A}
        color11 #${base0A}

        # blue
        color4  #${base0D}
        color12 #${base0D}

        # magenta
        color5  #${base0E}
        color13 #${base0E}

        # cyan
        color6  #${base0C}
        color14 #${base0C}

        # white
        color7  #${base07}
        color15 #${base07}
      '';
    };
  };
}
