{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # plugins = with pkgs.vimPlugins; [ nvim lspzero-nvim];
  };
  home.file = {
    ".config/nvim" = {
      enable = true;
      source = ./nvim;
      recursive = true;
    };
  };
}
