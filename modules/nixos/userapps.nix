{ inputs, pkgs, pkgs-stable, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  programs = {
    # droidcam.enable = true;
    appimage.enable = true;
  };
  services.flatpak.enable = true;

  programs = {
    partition-manager.enable = true;
    chromium.enable = true;
    firefox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    proton-vpn
    slack
    mpv
    qbittorrent
    ffmpeg-full
    inkscape
    discord
    osu-lazer-bin
    kdePackages.ark
    vlc
    gimp
    prismlauncher
    anki
    krita
    google-chrome
    pika-backup
    obsidian
    (pkgs.cava.override { withSDL2 = true; })
  ] ++ [
    pkgs-stable.calibre
    pkgs-stable.audacity
  ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    windowManagerPatch = true;
  };
}
