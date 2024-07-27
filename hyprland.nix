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
    ".config/hypr/nixthings.conf" = {
      enable = true;
      text = "exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &";
    };
  };
}
