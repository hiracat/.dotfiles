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
  hardware.amdgpu.opencl.enable = true;
  environment.systemPackages = with pkgs; [
    audacity
    brave
    obs-studio
    blender-hip
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
    davinci-resolve

    nemo-with-extensions
    nemo-fileroller
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
  ] ++ [ pkgs-stable.protonvpn-gui ];
}
