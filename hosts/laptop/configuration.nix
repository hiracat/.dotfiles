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
          "server" = { id = "IBSKWS6-RSVTTNQ-7BYL3UU-HX4W3AO-TYH5QGQ-BRE5556-743ZJVD-TYHSPQW"; };
        };
        folders = {
          "Desktop" = {
            path = "/home/${settings.username}/Desktop";
            devices = [ "server" ];
          };
          "Documents" = {
            path = "/home/${settings.username}/Documents";
            devices = [ "server" ];
          };
          "Downloads" = {
            path = "/home/${settings.username}/Downloads";
            devices = [ "server" ];
          };
          "Music" = {
            path = "/home/${settings.username}/Music";
            devices = [ "server" ];
          };
          "Pictures" = {
            path = "/home/${settings.username}/Pictures";
            devices = [ "server" ];
          };
          "Videos" = {
            path = "/home/${settings.username}/Videos";
            devices = [ "server" ];
          };
          ".dotfiles" = {
            path = "/home/${settings.username}/.dotfiles";
            devices = [ "server" ];
          };
        };
      };
    };
  };
}
