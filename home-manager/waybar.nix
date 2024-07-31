{ pkgs, config, pkgs-stable, nix-colors, home-manager, userSettings, systemSettings, lib, ... }:
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
        @define-color base00 #${config.colorScheme.palette.base00};
        @define-color base01 #${config.colorScheme.palette.base01};
        @define-color base02 #${config.colorScheme.palette.base02};
        @define-color base03 #${config.colorScheme.palette.base03};
        @define-color base04 #${config.colorScheme.palette.base04};
        @define-color base05 #${config.colorScheme.palette.base05};
        @define-color base06 #${config.colorScheme.palette.base06};
        @define-color base07 #${config.colorScheme.palette.base07};
        @define-color base08 #${config.colorScheme.palette.base08};
        @define-color base09 #${config.colorScheme.palette.base09};
        @define-color base0A #${config.colorScheme.palette.base0A};
        @define-color base0B #${config.colorScheme.palette.base0B};
        @define-color base0C #${config.colorScheme.palette.base0C};
        @define-color base0D #${config.colorScheme.palette.base0D};
        @define-color base0E #${config.colorScheme.palette.base0E};
        @define-color base0F #${config.colorScheme.palette.base0F};
      '';
    };
  };
}
