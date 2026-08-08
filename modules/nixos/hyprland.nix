{ pkgs, ... }:
let
  glazeSrc = pkgs.fetchFromGitHub {
    owner = "stephenberry";
    repo = "glaze";
    rev = "v7.2.0";
    hash = "sha256-f3NVRi3SXKo42hn0WCw7JsOK3EkdOVJIcuzhPorKjFY=";
  };
in

{
  programs.hyprland.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = prev.hyprland.overrideAttrs (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DFETCHCONTENT_SOURCE_DIR_GLAZE=${glazeSrc}"
          "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
        ];
        postPatch = (old.postPatch or "") + ''
          substituteInPlace CMakeLists.txt \
            --replace-fail 'find_package(glaze 7...<8 QUIET)' 'find_package(glaze QUIET)'
        '';
      });
    })
  ];


  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "start-hyprland";
        user = "forest";
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "default.target" ];
      wants = [ "default.target" ];
      after = [ "default.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  xdg.terminal-exec.enable = true;
  programs.nm-applet.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      networkmanagerapplet
      hyprsunset
      hypridle
      glib
      tofi
      hyprland-qtutils
      grim
      slurp
      dunst
      awww
      # autostart aps
      dex
      waybar
    ];
  };
}
