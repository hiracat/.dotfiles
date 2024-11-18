{ settings, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../scheme.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/periferals.nix
    ../../modules/nixos/software.nix

    # ../../modules/nixos/hyprland.nix
  ];
  base = {
    username = settings.username;
    hostname = "nixos-laptop";
  };
  periferals.drawingTablet.enable = true;

}
