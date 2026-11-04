{ pkgs, config, ... }:

{
  programs.hyprland.enable = true;
  services.displayManager.ly = {
    enable = true;
    # settings = { animation = "matrix"; };  # optional, on recent nixpkgs
  };
  # services.fprintd.enable = true;
  programs.hyprlock.enable = true; # also creates the "hyprlock" PAM service
  services.hypridle.enable = true;
  # security.pam.services.hyprlock.fprintAuth = false; # use hyprlock's own fprintd support instead
  # security.pam.services.ly.fprintAuth = false; # password at the login screen




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
  security.pam.services.ly.enableGnomeKeyring = true;
  programs.seahorse.enable = true;


  environment.etc."hypr-stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      networkmanagerapplet
      hyprsunset
      glib
      tofi
      grim
      tesseract
      slurp
      dunst
      awww
      # autostart aps
      dex
      waybar
    ];
  };
}
