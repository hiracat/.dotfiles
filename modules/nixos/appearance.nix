{ pkgs, ... }: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    # console.colors is deliberately left unset. It is a build-time option, so it
    # cannot follow matugen, which regenerates the palette at runtime whenever the
    # wallpaper changes. The TTY palette is instead applied at runtime from
    # templates/console_colors.sh -> ~/.config/console/colors.sh, sourced by
    # modules/home-manager/shell.nix when $TERM = linux.
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nanum
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
