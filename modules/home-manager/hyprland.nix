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
  # xdg.configFile."hypr/hypridle.conf" = {
  #   source = ./hypr/hypridle.conf;
  # };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
}
