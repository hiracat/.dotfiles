{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
    # ./qt.nix
    ./gtk.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  xdg.configFile."hypr/hyprsunset.conf" = {
    source = ./hypr/hyprsunset.conf;
  };
}
