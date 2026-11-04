{ settings, pkgs-stable, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/3dprinting.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/caps2escape.nix
    ../../modules/nixos/console.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/eduroam.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/ntfy.nix
    ../../modules/nixos/print.nix
    ../../modules/nixos/shellutils.nix
    ../../modules/nixos/syncthing.nix
    ../../modules/nixos/usb.nix
    ../../modules/nixos/userapps.nix
    ../../modules/nixos/virtualization.nix
  ];
  base = {
    username = settings.username;
    hostname = "nixos-laptop";
  };
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };
  services.xserver.wacom.enable = true;

  nix.settings = {
    cores = 2;
    max-jobs = 2;
  };


  services = {
    syncthingSync = {

      enable = true;
      username = settings.username;
      devices = {
        desktop = "FU5NOIY-RG6LIJ3-VWA64FP-6CEZXOP-KZEGB7S-7L3ET5Y-4ITXCDY-YTXXGA4";
        server = "IBSKWS6-RSVTTNQ-7BYL3UU-HX4W3AO-TYH5QGQ-BRE5556-743ZJVD-TYHSPQW";
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
