# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, userSettings, systemSettings, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      # moved to flake to more easily manage multiple machines
    ];

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

  console = {
    earlySetup = true;
    colors = with config.scheme; [
      #black
      "${base01}"
      #red
      "${base08}"
      #green
      "${base0B}"
      #yellow
      "${base0A}"
      #blue
      "${base0D}"
      #magenta
      "${base0E}"
      #cyan
      "${base0C}"
      #white
      "${base07}"

      #background
      #black
      "${base00}"
      #red
      "${base08}"
      #green
      "${base0B}"
      #yellow
      "${base0A}"
      #blue
      "${base0D}"
      #magenta
      "${base0E}"
      #cyan
      "${base0C}"
      #white
      "${base06}"

    ];
  };


  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-catppuccin
        fcitx5-mozc
      ];
    };
  };

  programs = {
    hyprland.enable = true;
    dconf.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    usbmuxd.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    blueman.enable = true;
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver.desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    xserver.displayManager.gdm.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  fonts = {
    packages = with pkgs; [
      nerdfonts
      fira
      kochi-substitute
      paratype-pt-serif
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrains Mono"
        ];
        sansSerif = [
          "Fira Sans"
          "Kochi Substitute"
        ];
        serif = [
          "PT Serif"
          "Kochi Substitute"
        ];
      };
    };
  };


  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };


  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 6;
    };
  };
}
