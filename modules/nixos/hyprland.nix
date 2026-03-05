{ pkgs, ... }: {
  programs.hyprland.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "start-hyprland";
        user = "forest";
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "default.target" ];
      wants = [ "default.target" ];
      after = [ "default.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  xdg.terminal-exec.enable = true;
  programs.nm-applet.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      networkmanagerapplet
      hyprsunset
      glib
      tofi
      hyprland-qtutils
      grim
      slurp
      dunst
      swww
      # autostart aps
      dex
      waybar
    ];
  };
}
