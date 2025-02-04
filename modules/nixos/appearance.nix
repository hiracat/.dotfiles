{ config, pkgs-stable, pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = with config.scheme; [
      #black
      "${base01}"
      #red
      "${base08}"
      #green
      "${base0B}"
      #yellow
      "${base0A}"
      #blue
      "${base0D}"
      #magenta
      "${base0E}"
      #cyan
      "${base0C}"
      #white
      "${base07}"

      #background
      #black
      "${base00}"
      #red
      "${base08}"
      #green
      "${base0B}"
      #yellow
      "${base0A}"
      #blue
      "${base0D}"
      #magenta
      "${base0E}"
      #cyan
      "${base0C}"
      #white
      "${base06}"

    ];
  };

  fonts = {
    packages = with pkgs-stable; [
      nerdfonts
      fira
      kochi-substitute
      paratype-pt-serif
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrains Mono"
        ];
        sansSerif = [
          "Fira Sans"
          "Kochi Substitute"
        ];
        serif = [
          "PT Serif"
          "Kochi Substitute"
        ];
      };
    };
  };
}
