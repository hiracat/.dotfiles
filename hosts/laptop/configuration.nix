{ settings, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../scheme.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/periferals.nix
    ../../modules/nixos/software.nix
    ../../modules/nixos/syncthing.nix

    ../../modules/nixos/hyprland.nix
  ];
  base = {
    username = settings.username;
    hostname = "nixos-laptop";
  };
  services.xserver.wacom.enable = true;

  services = {
    syncthingSync = {
      enable = true;
      username = settings.username;
      devices = {
        desktop = "FU5NOIY-RG6LIJ3-VWA64FP-6CEZXOP-KZEGB7S-7L3ET5Y-4ITXCDY-YTXXGA4";
        server = "IBSKWS6-RSVTTNQ-7BYL3UU-HX4W3AO-TYH5QGQ-BRE5556-743ZJVD-TYHSPQW";
      };
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
}
