{ home-manager }:
{
  home.file = {
    ".config/hypr" = {
      enable = true;
      source = ./hypr;
      recursive = true;
    };
  };
}
