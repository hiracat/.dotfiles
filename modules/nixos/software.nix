{ pkgs, pkgs-stable, settings, ... }: {
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

  users.users.${settings.username}.extraGroups = [ "libvirtd" ];
  programs = {
    virt-manager.enable = true;
    firejail.enable = true;
    gamemode.enable = true;
    firefox.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
  services = {
    atd.enable = true;
    cron.enable = true;
    printing.enable = true;
    flatpak.enable = true;
  };
  environment.systemPackages = with pkgs; [
    protonvpn-gui
    tradingview
    ruby

    libimobiledevice
    ifuse
    renderdoc
    qbittorrent-nox
    discord
    go
    nix-tree

    nemo-with-extensions
    nemo-fileroller
    base16-schemes
    git
    wl-clipboard
    ripgrep
    lutris
    bottles
    atuin

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

    spotify
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
  ] ++ [ pkgs-stable.cava pkgs-stable.kitty ];
}
