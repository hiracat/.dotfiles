{ config, pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:

let
  aliases = {
    ll = "ls -l";
    nv = "nvim";
    gc = ''f() { git add . && git commit -m "$1" && git push}; f'';
  };
in
{


  imports =
    [
      # Include the results of the hardware scan.
      ./neovim.nix
      ./hyprland.nix
      ./waybar.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  catppuccin.accent = "red";
  catppuccin.flavor = "mocha";
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern";
    cursorTheme.size = 16;

    catppuccin.enable = true;

    iconTheme.package = pkgs.candy-icons;
    iconTheme.name = "candy-icons";

    font = {
      name = "Fira Sans";
      size = 12;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

  };


  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    style.catppuccin.enable = true;
    style.catppuccin.apply = true;
  };
  services.dunst.enable = true;
  services.dunst.catppuccin.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    spotify
    prismlauncher
    blender
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
    anki
    feh
    grim
    slurp
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/forest/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { };

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      save = 10000;
      size = 10000;
      path = "${config.home.homeDirectory}/.histfile";
    };

    initExtra = ''
      eval "$(starship init zsh)"
      eval "$(atuin init zsh)"
      clear
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "no-rc"; # disable features if desired here
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    theme = "Catppuccin-Mocha";
    font.name = userSettings.font;
    font.size = 12;
    font.package = userSettings.fontPkg;
    extraConfig = ''
        '';
  };

  programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
