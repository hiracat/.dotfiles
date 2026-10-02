{ inputs, pkgs, pkgs-stable, settings, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
  };

  users.users.${settings.username}.extraGroups = [ "libvirtd" "input" "docker" ];

  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # optional but nice GUI
  hardware.steam-hardware.enable = true; # adds udev rules for controllers

  services.usbmuxd.enable = true;

  virtualisation.docker.enable = true;
  programs = {
    droidcam.enable = true;
    partition-manager.enable = true;
    appimage.enable = true;


    virt-manager.enable = true;
    firejail.enable = true;
    gamemode.enable = true;
    chromium.enable = true;

    gamescope.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
      windowManagerPatch = true;
    };
  };
  services = {
    udev.enable = true;
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    printing.enable = true;
    flatpak.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish.enable = true;
    };
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];
  xdg.portal.config = {
    common.default = [ "gtk" ];
    hyprland.default = [ "hyprland" "gtk" ];
  };

  environment.etc."jdks/bellsoft-25".source = pkgs.bellsoft-jdk;

  # NOTE: shared CLI tooling (git, ripgrep, fzf, btop, nil, clang-tools, ...) lives in
  # base.nix and is deliberately NOT repeated here.
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm
    jetbrains.idea
    bellsoft-jdk
    linux-wifi-hotspot
    pritunl-client
    watchexec
    pwvucontrol
    proton-vpn
    audacity
    brave
    firefox
    slack
    wl-clicker
    gh
    qpwgraph
    ruby
    mpv
    qbittorrent
    kvirc
    ffmpeg-full
    ironwail
    (python3.withPackages (ps: with ps; [ tkinter matplotlib typer ]))

    archipelago

    libimobiledevice
    ifuse
    qbittorrent-nox
    discord
    go

    playerctl
    osu-lazer-bin

    curl
    kdePackages.ark
    vlc
    gimp
    xdg-user-dirs

    libnotify
    alsa-utils
    mangohud

    prismlauncher
    krita
    obsidian

    tree-sitter
    lua-language-server
    shader-slang
    typescript-language-server
    prettier
    nodejs
    gdb
    lldb
    vscode-extensions.vadimcn.vscode-lldb
    cmake
    cmake-language-server
    qimgv
    anki
    google-chrome
    brightnessctl
    (pkgs.cava.override { withSDL2 = true; })
    nemo-with-extensions
    nemo-fileroller
  ] ++ [
    pkgs-stable.pika-backup
    pkgs-stable.calibre
    pkgs-stable.bottles
  ];

}
