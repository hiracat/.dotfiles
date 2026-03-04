{ inputs, pkgs, pkgs-stable, settings, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  bambu-studio = pkgs.appimageTools.wrapType2 rec {
    name = "BambuStudio";
    pname = "bambu-studio";
    version = "02.05.00.67";
    ubuntu_version = "24.04_PR-9540";

    src = pkgs.fetchurl {
      url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_ubuntu-${ubuntu_version}.AppImage";
      sha256 = "sha256:3ubZblrsOJzz1p34QiiwiagKaB7nI8xDeadFWHBkWfg=";
    };

    profile = ''
      export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
    '';

    extraPkgs =
      pkgs: with pkgs; [
        cacert
        glib
        glib-networking
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        webkitgtk_4_1
      ];
  };
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

  programs = {
    partition-manager.enable = true;

    virt-manager.enable = true;
    firejail.enable = true;
    gamemode.enable = true;
    chromium.enable = true;
    droidcam.enable = true;


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
    bottles
    pavucontrol
    protonvpn-gui
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
    nodePackages.npm
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
    calibre
    google-chrome
    brightnessctl
    cava
    nemo-with-extensions
    nemo-fileroller
  ] ++ [
    pkgs-stable.pika-backup
    bambu-studio
  ];

}
