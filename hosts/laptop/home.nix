{ pkgs, settings, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  imports = [
    ../../scheme.nix
    ../../modules/home-manager/cava.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/obsidian.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/git.nix

    ../../modules/home-manager/hyprland.nix
  ];

  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";



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
