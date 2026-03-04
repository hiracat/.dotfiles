{ pkgs, ... }:
{
  imports = [
    # ./qt.nix
    ./gtk.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
  home.pointerCursor = {
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
