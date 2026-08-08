{ pkgs, ... }:
{
  imports = [
    # TODO: ./qt.nix
    ./gtk.nix
    ./coloring.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemd.enable = true;
    configType = "lua";
    extraConfig = builtins.readFile ./hypr/hyprland.lua;
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  xdg.configFile = {
    "waybar" = {
      enable = true;
      source = ./waybar;
      recursive = true;
    };
  };
  xdg.configFile."hypr/hyprsunset.conf" = {
    source = ./hypr/hyprsunset.conf;
  };
}
