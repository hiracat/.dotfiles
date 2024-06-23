{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  home.file = {
    ".config/waybar" = {
      enable = true;
      source = ./waybar;
      recursive = true;
    };
  };
}
