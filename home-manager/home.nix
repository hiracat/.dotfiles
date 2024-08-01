{ pkgs, userSettings, inputs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  imports = [
    ./cava.nix
    ./gtk.nix
    ./hyprland.nix
    ./kitty.nix
    ./neovim.nix
    ./qt.nix
    ./shell.nix
    ./waybar.nix
    ./dunst.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  # colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  # colorScheme = inputs.nix-colors.colorSchemes.colors;
  colorScheme = inputs.nix-colors.colorSchemes.everforest;


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
