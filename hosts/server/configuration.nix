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
    ../../modules/nixos/syncthing.nix

    # ../../modules/nixos/hyprland.nix
  ];
  base = {
    username = settings.username;
    hostname = "nixos-server";
  };
  periferals.drawingTablet.enable = true;

  services = {
    syncthingSync = {
      enable = true;
      username = settings.username;
      devices = {
        desktop = "FU5NOIY-RG6LIJ3-VWA64FP-6CEZXOP-KZEGB7S-7L3ET5Y-4ITXCDY-YTXXGA4";
        laptop = "VZOYB44-PL3RROB-ZXQAYVC-GEPOXOK-ISOGJ26-CRZ6BBU-4HMTIML-6LHENQU";
      };
      folders = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".local/share/PrismLauncher"
        ".dotfiles"
      ];
    };
  };
}
