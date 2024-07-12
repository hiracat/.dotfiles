{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  home.file = {
    ".config/waybar" = {
      enable = false;
      source = ./waybar;
      recursive = true;
    };
  };
}
