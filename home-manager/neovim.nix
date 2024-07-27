{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  home.file = {
    ".config/nvim" = {
      enable = true;
      source = ./nvim;
      recursive = true;
    };
  };
}
