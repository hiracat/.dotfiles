{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  programs.waybar.enable = true;
  home.file = {
    ".config/waybar" = {
      enable = true;
      source = ./waybar;
      recursive = true;
    };
  };
}
