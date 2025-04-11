{ pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  programs.zsh.loginShellInit = ''
    if uwsm check may-start && uwsm select; then
      exec systemd-cat -t uwsm_start uwsm start default
    fi
  '';

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
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
    hyprsunset
      glib
      tofi
      hyprland-qtutils
      grim
      slurp
      dunst
      swww
    ];
  };
}
