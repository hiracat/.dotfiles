{ config, pkgs, ... }: {
  console = {
    earlySetup = true;
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
    packages = with pkgs; [
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