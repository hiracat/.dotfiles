{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./qt.nix
    ./gtk.nix
  ];

  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };

  xdg.configFile."hypr/hypridle.conf" = {
    source = ./hypr/hypridle.conf;
  };
}
