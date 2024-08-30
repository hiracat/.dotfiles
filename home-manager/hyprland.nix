{ pkgs, ... }:
{
  user.systemd.extraServices.polkit_gnome_agent = {
    description = "gnome polkit graphical authentication agent";
    wantedBy = [ "hyprland-session.target" ];
    wants = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
}
