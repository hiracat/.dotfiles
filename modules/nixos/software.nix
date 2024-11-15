{ lib, config, pkgs }: {
  options = {
    software.general.enable = lib.mkEnableOption "software for everything i use ";
  };
  config = lib.mkIf config.software.general.enable {
    programs = {
      firejail.enable = true;
      partition-manager.enable = true;
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
    };
    environment.systemPackages = with pkgs; [
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
      qbittorrent-nox
      discord
      go
      nix-tree

      nemo-with-extensions
      nemo-fileroller
      cava
      base16-schemes
      git
      wl-clipboard
      ripgrep
      lutris
      bottles
      kitty
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
      blender-hip
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
    ];
  };
}
