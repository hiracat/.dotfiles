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
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        swtpm.enable = true;
      };
    };
  };

  users.users.${settings.username}.extraGroups = [ "libvirtd" "input" ];
  virtualisation.docker.enable = true;

  programs = {
    partition-manager.enable = true;

    virt-manager.enable = true;
    firejail.enable = true;
    gamemode.enable = true;
    chromium.enable = true;

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
    };
  };
  services = {
    atd.enable = true;
    cron.enable = true;
    printing.enable = true;
    flatpak.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  # for davanci resolve
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];


  environment.systemPackages = with pkgs; [
    watchexec
    bottles
    pavucontrol
    bambu-studio
    orca-slicer
    protonvpn-gui
    audacity
    brave
    obs-studio
    wl-clicker
    gh
    pika-backup
    ruby

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
    nodePackages.npm
    fd
    cargo
    curl
    rar
    libsForQt5.ark
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
    anki
    calibre
    google-chrome
  ] ++ [
    pkgs-stable.nemo-with-extensions
    pkgs-stable.nemo-fileroller
    pkgs-stable.davinci-resolve
  ];

}
