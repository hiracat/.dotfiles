{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = " ";
  };
  home.file = {
    ".config/hypr" = {
      enable = true;
      source = ./hypr;
      recursive = true;
    };
  };
}
