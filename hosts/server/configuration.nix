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
    hostname = "nixos-server";
  };
  periferals.drawingTablet.enable = true;

  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = settings.username;
      dataDir = "/home/${settings.username}/Syncthing";
      configDir = "/home/${settings.username}/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "desktop" = { id = "FU5NOIY-RG6LIJ3-VWA64FP-6CEZXOP-KZEGB7S-7L3ET5Y-4ITXCDY-YTXXGA4"; };
          "laptop" = { id = "VZOYB44-PL3RROB-ZXQAYVC-GEPOXOK-ISOGJ26-CRZ6BBU-4HMTIML-6LHENQU"; };
        };
        folders = {
          "Desktop" = {
            path = "/home/${settings.username}/Desktop";
            devices = [ "desktop" "laptop" ];
          };
          "Documents" = {
            path = "/home/${settings.username}/Documents";
            devices = [ "desktop" "laptop" ];
          };
          "Downloads" = {
            path = "/home/${settings.username}/Downloads";
            devices = [ "desktop" "laptop" ];
          };
          "Music" = {
            path = "/home/${settings.username}/Music";
            devices = [ "desktop" "laptop" ];
          };
          "Pictures" = {
            path = "/home/${settings.username}/Pictures";
            devices = [ "desktop" "laptop" ];
          };
          "Videos" = {
            path = "/home/${settings.username}/Videos";
            devices = [ "desktop" "laptop" ];
          };
          ".dotfiles" = {
            path = "/home/${settings.username}/.dotfiles";
            devices = [ "desktop" "laptop" ];
          };
        };
      };
    };
  };
}
