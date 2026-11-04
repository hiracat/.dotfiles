{ pkgs, lib, config, ... }:
{
  imports = [
    # TODO: ./qt.nix
    ./gtk.nix
    ./coloring.nix
  ];

  options.hypr = {
    hypridleConfig = lib.mkOption {
      type = lib.types.path;
      default = ./hypr/hypridle.conf;
      description = ''
        hypridle.conf to install for this host. hypridle is configured in its own
        native format rather than through nix, so hosts select a whole file here.
      '';
    };
    autostartConfig = lib.mkOption {
      type = lib.types.path;
      default = ./hypr/autostart.lua;
      description = ''
        lua file appended after hyprland.lua that registers the hyprland.start
        handler. Lets each host pick which applications autostart without
        duplicating the rest of the hyprland config.
      '';
    };
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      systemd.enable = true;
      configType = "lua";
      extraConfig =
        builtins.readFile ./hypr/hyprland.lua
        + "\n"
        + builtins.readFile config.hypr.autostartConfig;
    };
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
    xdg.configFile = {
      "waybar" = {
        enable = true;
        source = ./waybar;
        recursive = true;
      };
      "hypr/hyprsunset.conf".source = ./hypr/hyprsunset.conf;
      "hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
      "hypr/hypridle.conf".source = config.hypr.hypridleConfig;
    };
  };
}
