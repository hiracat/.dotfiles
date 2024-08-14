{ config, ... }:
{
  home.file = {
    ".config/nvim" = {
      enable = true;
      source = ./nvim;
      recursive = true;
    };
  };
  home.file = {
    # have to hack around the fact that file watchers automatically look
    # at the source of the symlink instead of the link itself
    ".cache/colorschemes/nvimcolors.lua" = {
      enable = true;
      text = with config.scheme; ''
        require("catppuccin").setup {
          color_overrides = {
            mocha = {
              base = "#${base00}",
              mantle = "#${base01}",
              crust = "#${base01}",
              surface0 = "#${base02}",
              surfacet = "#${base03}",
              surface2 = "#${base04}",
              text = "#${base05}",
              subtext0 = "#${base05}",
              subtext1 = "#${base05}",
              overlay0 = "#${base06}",
              overlay1 = "#${base07}",
              overlay2 = "#${base07}",
              rosewater = "#${base0F}",
              flamingo = "#${base0F}",
              pink = "#${base0E}",
              mauve = "#${base0E}",
              red = "#${base08}",
              maroon = "#${base08}",
              peach = "#${base09}",
              yellow = "#${base0A}",
              green = "#${base0B}",
              teal = "#${base0C}",
              sky = "#${base0C}",
              sapphire = "#${base0C}",
              blue = "#${base0D}",
              lavender = "#${base0D}"
            }
          }
        }
      '';
    };
  };
}
