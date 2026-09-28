{ pkgs, ... }: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        catppuccin-fcitx5
        fcitx5-mozc
        fcitx5-hangul
      ];
    };
  };

  # XMODIFIERS is already set unconditionally by the i18n.inputMethod.fcitx5
  # module, and with waylandFrontend = true that module deliberately leaves
  # QT_IM_MODULE and GTK_IM_MODULE unset so Qt/GTK apps use the native Wayland
  # text-input protocol rather than the legacy IM plugins. Setting QT_IM_MODULE
  # here used to override that. Both are therefore no longer defined here.
  #
  # SDL_IM_MODULE is the one variable the module does not provide, and SDL2's
  # X11 IME backend does read it, so it is kept for XWayland games.
  environment.sessionVariables = {
    SDL_IM_MODULE = "fcitx";
  };
}
