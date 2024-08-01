# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, userSettings, systemSettings, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with inputs.config.boot.kernelPackages; [ ];

    # Bootloader.
    loader.grub.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.grub.device = "nodev";
    loader.grub.efiSupport = true;
    loader.systemd-boot.enable = false;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    hostName = systemSettings.hostname;
  };

  hardware = {
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  i18n = {
    # Select internationalisation properties.
    defaultLocale = systemSettings.locale;
    extraLocaleSettings = {
      LC_ADDRESS = systemSettings.locale;
      LC_IDENTIFICATION = systemSettings.locale;
      LC_MEASUREMENT = systemSettings.locale;
      LC_MONETARY = systemSettings.locale;
      LC_NAME = systemSettings.locale;
      LC_NUMERIC = systemSettings.locale;
      LC_PAPER = systemSettings.locale;
      LC_TELEPHONE = systemSettings.locale;
      LC_TIME = systemSettings.locale;
    };
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
    neovim.enable = true;
    partition-manager.enable = true;
    zsh.enable = true;
    gamemode.enable = true;
    firefox.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    atd.enable = true;
    cron.enable = true;
    fstrim.enable = true;
    blueman.enable = true;
    dbus.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver.xkb = {

      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
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

  security.rtkit.enable = true;
  security.polkit.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "forest";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password"; # for vms
  };
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      TERMINAL = userSettings.terminal;
      EDITOR = userSettings.editor;
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-46.0/glib-2.0/schemas";
    };
    pathsToLink = [ "/share/zsh" ];
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      adwaita-icon-theme
      glib
      gsettings-desktop-schemas
      kdePackages.breeze


      nemo-with-extensions
      nemo-fileroller
      cava
      base16-schemes
      git
      dunst
      wl-clipboard
      ripgrep
      lutris
      bottles
      kitty
      atuin
      calibre
      nwg-look

      fastfetch
      gcc
      starship
      wget
      unzip
      nodePackages.npm
      fd
      cargo
      curl
      rar
      libsForQt5.ark
      vlc
      htop
      gimp
      xdg-user-dirs

      rofi-wayland
      playerctl
      libnotify
      alsa-utils
      mangohud

      wayland-protocols
      wayland-utils
      wlroots
      networkmanagerapplet

      spotify
      prismlauncher
      krita
      blender-hip
      obsidian
      termdown
      fzf
      polkit_gnome

      stylua
      shfmt
      nixpkgs-fmt
      nil
      lua-language-server
      lua
      gdb
      cmake
      #cmake-language-server
      clang-tools
      vulkan-tools
      anki
      feh
      grim
      slurp
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "24.05"; # Did you read the comment?
    autoUpgrade.enable = false;
    autoUpgrade.allowReboot = false;
  };
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192; # Use 2048MiB memory.
      cores = 6;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
