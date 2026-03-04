{ pkgs, config, inputs, lib, ... }: {

  xdg.systemDirs.data =
    let
      schema = pkgs.gsettings-desktop-schemas;
    in
    [ "${schema}/share/gsettings-schemas/${schema.name}" ];


  gtk = {
    enable = true;

    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";
    cursorTheme.size = 16;

    iconTheme.package = pkgs.candy-icons;
    iconTheme.name = "candy-icons";

    theme.name = "adw-gtk3";
    theme.package = pkgs.adw-gtk3;


    font = {
      name = "Fira Sans";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = "true";
    };

    gtk4.extraConfig = {
      "[AdwStyleManager]\n color-scheme" = "ADW_COLOR_SCHEME_PREFER_DARK";
    };

    gtk3.extraCss = ''
      @import 'colors.css';
    '';
    gtk4.extraCss = ''
      @import 'colors.css';
    '';
  };
}
