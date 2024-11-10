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

  systemd.coredump.enable = false; # make core dumps appear in the working directory

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


  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
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
    firejail.enable = true;
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
    usbmuxd.enable = true;
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
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
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

  security.sudo.extraRules = [{
    users = [ userSettings.username ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  }];


  users.defaultUserShell = pkgs.zsh;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "forest";
    extraGroups = [ "networkmanager" "wheel" "video" ];
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
    };
    pathsToLink = [ "/share/zsh" ];
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      tradingview
      gcc
      gnumake
      ruby
      rustc
      clippy
      rustfmt
      cargo
      rust-analyzer

      libimobiledevice
      ifuse
      renderdoc
      hypridle
      qbittorrent-nox
      discord
      go
      swww
      nix-tree
      adwaita-icon-theme
      glib
      gsettings-desktop-schemas


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
      cmake-language-server
      clang-tools
      vulkan-tools
      feh
      grim
      slurp
    ] ++ [ pkgs-stable.anki pkgs-stable.calibre ];
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
