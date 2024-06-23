{ pkgs, pkgs-stable, home-manager, userSettings, systemSettings, lib, ... }:
{
  home.file = {
    ".config/hypr" = {
      enable = true;
      source = ./hypr;
      recursive = true;
    };
  };
}
