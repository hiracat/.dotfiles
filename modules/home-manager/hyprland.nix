{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
  home.file.".config/hypr/hypridle.conf" = {
    source = ./hypr/hypridle.conf;
  };
}
