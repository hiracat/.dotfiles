{ pkgs, lib, config, ... }: {
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
      firewall.allowedTCPPorts = [ 1070 25565 ];
      firewall.allowedUDPPorts = [ 25565 ];

    };
    services.fstrim.enable = true;


    time.timeZone = config.base.timezone;
    i18n = {
      # Select internationalisation properties.
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "ko_KR.UTF-8/UTF-8" ];

      extraLocaleSettings = {
        LC_ALL = "en_US.UTF-8";
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
      ports = [ 1070 ];
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = false;
      settings.X11Forwarding = false;
      settings.AllowUsers = [ "forest" ];
      hostKeys = [{
        path = "/etc/ssh/ssh_host_ed25519_key";
        rounds = 100;
        type = "ed25519";
      }];


      extraConfig = ''
        ClientAliveInterval 300
      '';
    };
    age.secrets.ssh_config = {
      file = ../../secrets/ssh_config.age;
      owner = config.base.username;
      mode = "0600";
    };
    programs.ssh.extraConfig = "Include ${config.age.secrets.ssh_config.path}";

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    programs = {
      zsh.enable = true;
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWnGWDG2ooTzY+PCnLWpib1Yn9il+FWOB0Kw0KorTn+ forest@nixos-laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFUxgeebT7z1hHD7b64eICy6G1IH2GNVQ/4ZHKJow1Me forest@nixos-server"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9X++QDuK2Uh5nV2X8P8ratkLV9U7CYLIUoj909tAHx forest@nixos-desktop"
      ];

    };
    environment = {
      sessionVariables = {
        TERMINAL = "kitty";
        EDITOR = "nvim";
      };

      shells = with pkgs; [ zsh ];
      pathsToLink = [ "/share/zsh" ];
      systemPackages = with pkgs; [
        neovim
        gcc
        gnumake
        adwaita-icon-theme
        adwaita-icon-theme-legacy
        kdePackages.breeze-icons

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
