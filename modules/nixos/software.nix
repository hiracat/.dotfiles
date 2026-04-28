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

  users.users.${settings.username}.extraGroups = [ "libvirtd" "input" ];
  virtualisation.docker.enable = true;

  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # optional but nice GUI
  hardware.steam-hardware.enable = true; # adds udev rules for controllers

  programs = {
    partition-manager.enable = true;
    appimage.enable = true;


    virt-manager.enable = true;
    firejail.enable = true;
    gamemode.enable = true;
    chromium.enable = true;
    droidcam.enable = true;


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
    atd.enable = true;
    cron.enable = true;
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


  environment.systemPackages = with pkgs; [
    hyprsunset
    watchexec
    pavucontrol
    proton-vpn
    audacity
    brave
    obs-studio
    wl-clicker
    gh
    ruby
    mpv
    qbittorrent
    kvirc
    ffmpeg

    libimobiledevice
    ifuse
    qbittorrent-nox
    discord
    go
    nix-tree

    base16-schemes
    git
    wl-clipboard
    ripgrep
    atuin
    playerctl

    fastfetch
    starship
    wget
    unzip
    fd
    curl
    rar
    kdePackages.ark
    vlc
    htop
    btop
    gimp
    xdg-user-dirs

    libnotify
    alsa-utils
    mangohud

    prismlauncher
    krita
    obsidian
    termdown
    fzf

    tree-sitter
    stylua
    shfmt
    nixpkgs-fmt
    nil
    lua-language-server
    lua
    gdb
    lldb
    vscode-extensions.vadimcn.vscode-lldb
    cmake
    cmake-language-server
    clang-tools
    vulkan-tools
    feh
    anki
    google-chrome
    brightnessctl
    cava
    nemo-with-extensions
    nemo-fileroller
    bambu-studio
  ] ++ [
    pkgs-stable.pika-backup
    pkgs-stable.calibre
    pkgs-stable.bottles
  ];

}
