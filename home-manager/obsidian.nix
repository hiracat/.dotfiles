{ config, ... }: {

  home.file."Documents/The Vault/.obsidian/snippets/base16.css" = {
    enable = true;
    text = with config.scheme; ''
        .theme-dark.ctp-mocha {
        --ctp-rosewater: ${base0F-rgb-r}, ${base0F-rgb-g}, ${base0F-rgb-b};
        --ctp-flamingo: ${base0F-rgb-r}, ${base0F-rgb-g}, ${base0F-rgb-b};
        --ctp-pink: ${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b};
        --ctp-mauve: ${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b};
        --ctp-red: ${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b};
        --ctp-maroon: ${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b};
        --ctp-peach: ${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b};
        --ctp-yellow: ${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b};
        --ctp-green: ${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b};
        --ctp-teal: ${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b};
        --ctp-sky: ${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b};
        --ctp-sapphire: ${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b};
        --ctp-blue: ${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b};
        --ctp-lavender: ${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b};

        --ctp-text: ${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b};
        --ctp-subtext1: ${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b};
        --ctp-subtext0: ${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b};
        --ctp-overlay2: ${base07-rgb-r}, ${base07-rgb-g}, ${base07-rgb-b};
        --ctp-overlay1: ${base07-rgb-r}, ${base07-rgb-g}, ${base07-rgb-b};
        --ctp-overlay0: ${base06-rgb-r}, ${base06-rgb-g}, ${base06-rgb-b};
        --ctp-surface2: ${base04-rgb-r}, ${base04-rgb-g}, ${base04-rgb-b};
        --ctp-surface1: ${base03-rgb-r}, ${base03-rgb-g}, ${base03-rgb-b};
        --ctp-surface0: ${base02-rgb-r}, ${base02-rgb-g}, ${base02-rgb-b};
        --ctp-base: ${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b};
        --ctp-mantle: ${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b};
        --ctp-crust: ${base01-rgb-r}, ${base01-rgb-g}, ${base01-rgb-b};

        --hex-rosewater: ${withHashtag.base0F};
        --hex-flamingo: ${withHashtag.base0F};
        --hex-pink: ${withHashtag.base0E};
        --hex-mauve: ${withHashtag.base08};
        --hex-red: ${withHashtag.base08};
        --hex-maroon: ${withHashtag.base08};
        --hex-peach: ${withHashtag.base09};
        --hex-yellow: ${withHashtag.base0A};
        --hex-green: ${withHashtag.base0B};
        --hex-teal: ${withHashtag.base0C};
        --hex-sky: ${withHashtag.base0C};
        --hex-sapphire: ${withHashtag.base0C};
        --hex-blue: ${withHashtag.base0D};
        --hex-lavender: ${withHashtag.base0D};
      }
    '';
  };
}
