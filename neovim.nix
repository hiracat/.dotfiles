{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  programs.neovim = {
    enable = true;
    # plugins = with pkgs.vimPlugins; [ nvim lspzero-nvim];
  };
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

    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
