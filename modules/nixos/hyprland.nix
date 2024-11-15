{ pkgs, ... }: {
  systemd.user.services.polkit-gnome-agent = {
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
  programs = {
    hyprland.enable = true;
    dconf.enable = true;
  };
  services = {
    xserver.displayManager.gdm.enable = true;

    gnome.gnome-keyring.enable = true;
    usbmuxd.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    dbus.enable = true;
    # xserver.desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
