{ pkgs, lib, pkgs-stable, config, ... }: {
  options.base = {
    locale = lib.mkOption {
      default = "en_US.UTF-8";
      description = "system locale";
    };
    timezone = lib.mkOption {
      default = "America/New_York";
      description = "system timezone";
    };
    username = lib.mkOption {
      default = "forest";
      description = "main users username";
    };
    hostname = lib.mkOption {
      default = "nixos";
      description = "system hostname";
    };
  };

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };

    networking = {
      hostName = config.base.hostname;
      networkmanager.enable = true;
      firewall.enable = true;
    };
    services.fstrim.enable = true;

    time.timeZone = config.base.timezone;
    i18n = {
      # Select internationalisation properties.
      defaultLocale = config.base.locale;
      extraLocaleSettings = {
        LC_ADDRESS = config.base.locale;
        LC_IDENTIFICATION = config.base.locale;
        LC_MEASUREMENT = config.base.locale;
        LC_MONETARY = config.base.locale;
        LC_NAME = config.base.locale;
        LC_NUMERIC = config.base.locale;
        LC_PAPER = config.base.locale;
        LC_TELEPHONE = config.base.locale;
        LC_TIME = config.base.locale;
      };
    };
    services.interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };

    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };
    programs = {
      zsh.enable = true;
      neovim.enable = true;
    };
    security.rtkit.enable = true;
    security.polkit.enable = true;
    security.sudo.extraRules = [{
      users = [ config.base.username ];
      commands = [{
        command = "/run/current-system/sw/bin/nixos-rebuild";
        options = [ "NOPASSWD" ];
      }];
    }];
    users.defaultUserShell = pkgs.zsh;
    users.users.${config.base.username} = {
      isNormalUser = true;
      description = "forest";
      extraGroups = [ "dialout" "networkmanager" "wheel" "video" "vboxusers" ];
      initialPassword = "password"; # for vms
    };
    environment = {
      sessionVariables = {
        TERMINAL = "kitty";
        EDITOR = "nvim";
      };

      shells = with pkgs; [ zsh ];
      pathsToLink = [ "/share/zsh" ];
      systemPackages = with pkgs; [
        gcc
        gnumake

        rust-analyzer
        rustc
        clippy
        rustfmt
        cargo
        glslls

        nix-tree
        base16-schemes
        git
        wl-clipboard
        ripgrep
        atuin
        fastfetch
        starship
        wget
        unzip
        fd
        rar
        htop
        btop
        termdown
        fzf
        stylua
        shfmt
        nixpkgs-fmt
        nil
        lua-language-server
        lua
        gdb
        clang-tools
        vulkan-tools
      ] ++ [
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
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
