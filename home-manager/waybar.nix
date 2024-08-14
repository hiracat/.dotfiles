{ config, ... }:
{
  programs.waybar.enable = true;
  home.file = {
    ".config/waybar" = {
      enable = true;
      source = ./waybar;
      recursive = true;
    };
    ".config/waybar/colors.css" = {
      enable = true;
      text = ''
        @define-color base00 #${config.scheme.base00};
        @define-color base01 #${config.scheme.base01};
        @define-color base02 #${config.scheme.base02};
        @define-color base03 #${config.scheme.base03};
        @define-color base04 #${config.scheme.base04};
        @define-color base05 #${config.scheme.base05};
        @define-color base06 #${config.scheme.base06};
        @define-color base07 #${config.scheme.base07};
        @define-color base08 #${config.scheme.base08};
        @define-color base09 #${config.scheme.base09};
        @define-color base0A #${config.scheme.base0A};
        @define-color base0B #${config.scheme.base0B};
        @define-color base0C #${config.scheme.base0C};
        @define-color base0D #${config.scheme.base0D};
        @define-color base0E #${config.scheme.base0E};
        @define-color base0F #${config.scheme.base0F};
      '';
    };
  };
}
