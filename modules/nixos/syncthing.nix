{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in
{
  options = {
    services.syncthingSync = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Syncthing configuration module";
      };

      username = mkOption {
        type = types.str;
        description = "The system username to run Syncthing under";
      };

      devices = mkOption {
        type = types.attrsOf types.str;
        description = "A mapping of device names to Syncthing device IDs";
      };

      folders = mkOption {
        type = types.listOf types.str;
        description = "List of folders (relative to home) to sync";
      };
    };
  };

  config = lib.mkIf config.services.syncthingSync.enable {
    services.syncthing = {
      enable = true;
      user = config.services.syncthingSync.username;
      group = "users";
      dataDir = "/home/${config.services.syncthingSync.username}/Syncthing";
      configDir = "/home/${config.services.syncthingSync.username}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = lib.mapAttrs (name: id: { inherit id; }) config.services.syncthingSync.devices;

        folders = lib.listToAttrs (map
          (folderName:
            let
              path = "/home/${config.services.syncthingSync.username}/${folderName}";
            in
            {
              name = folderName;
              value = {
                inherit path;
                devices = builtins.attrNames config.services.syncthingSync.devices;
              };
            }
          )
          config.services.syncthingSync.folders);
      };
    };
  };
}
