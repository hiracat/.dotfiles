{ settings, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/software.nix

    ../../modules/nixos/syncthing.nix
    ../../modules/nixos/hyprland.nix
  ];
  base = {
    username = settings.username;
    hostname = "nixos-server";
  };


  services.calibre-server = {
    enable = true;
    libraries = [ "/home/forest/Documents/Calibre Library" ];
    openFirewall = true;
    user = "forest";
    group = "users";

  };

  networking = {
    firewall.allowedUDPPorts = [ 24454 ];
  };

  services = {
    minecraft-server = {
      package = pkgs.stdenv.mkDerivation {
        pname = "fabric-server";
        version = "26.1.2";
        src = pkgs.fetchurl {
          url = "https://meta.fabricmc.net/v2/versions/loader/26.1.2/0.19.3/1.1.1/server/jar";
          sha256 = "sha256-2Dd+CWOoTxt+tMXosmMGj2NcSkMM+hWnkkFUjSjw/aA=";
        };
        nativeBuildInputs = [ pkgs.makeWrapper ];
        dontUnpack = true;

        installPhase = ''
          mkdir -p $out/lib/minecraft
          cp $src $out/lib/minecraft/server.jar

          makeWrapper ${pkgs.lib.getExe pkgs.openjdk25_headless} $out/bin/minecraft-server \
            --append-flags "-jar $out/lib/minecraft/server.jar nogui"

        '';
      };

      eula = true;
      enable = true;
      openFirewall = true;
      jvmOpts = "-Xmx6000M -Xms6000M";
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
