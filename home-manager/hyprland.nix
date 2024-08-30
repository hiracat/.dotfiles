{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
}
