{ config, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  imports = [
    ../../modules/home-manager/cava.nix
    # ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/kitty.nix
    # ../../modules/home-manager/qt.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/dunst.nix
    ../../modules/home-manager/obsidian.nix
    ../../modules/home-manager/neovim.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = config.base.username;
  home.homeDirectory = "/home/${config.base.username}";


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
