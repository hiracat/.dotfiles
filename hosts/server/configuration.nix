{ settings, pkgs, ... }: {
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


  networking = {
    firewall.allowedUDPPorts = [ 24454 ];
  };

  services = {
    minecraft-server = {
      package = pkgs.stdenv.mkDerivation {
        pname = "fabric-server";
        version = "1.21.9"; # adjust version
        src = pkgs.fetchurl {
          url = "https://meta.fabricmc.net/v2/versions/loader/1.21.9/0.17.3/1.1.0/server/jar";
          sha256 = "sha256-MYNG/SAJOQrnSHC05v6lTeXz+BKChBF+IqCLJdwVHIQ="; # replace with actual hash
        };
        nativeBuildInputs = [ pkgs.makeWrapper ];
        dontUnpack = true;

        installPhase = ''
          mkdir -p $out/lib/minecraft
          cp $src $out/lib/minecraft/server.jar

          makeWrapper ${pkgs.lib.getExe pkgs.jre_headless} $out/bin/minecraft-server \
            --append-flags "-jar $out/lib/minecraft/server.jar nogui"

        '';
      };

      eula = true;
      enable = true;
      openFirewall = true;
      jvmOpts = "-Xmx5000M -Xms5000M";
    };
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
