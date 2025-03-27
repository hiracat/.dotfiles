{ pkgs, ... }: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-catppuccin
        fcitx5-mozc
        fcitx5-hangul
      ];
    };
  };
  environment = {
    sessionVariables = {
      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };
}
