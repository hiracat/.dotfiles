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
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "Documents" = {
            path = "/home/${settings.username}/Documents";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "Downloads" = {
            path = "/home/${settings.username}/Downloads";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "Music" = {
            path = "/home/${settings.username}/Music";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "Pictures" = {
            path = "/home/${settings.username}/Pictures";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "Videos" = {
            path = "/home/${settings.username}/Videos";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          ".dotfiles" = {
            path = "/home/${settings.username}/.dotfiles";
            devices = [ "desktop" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
        };
      };
    };
  };

}
