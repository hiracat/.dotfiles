{ pkgs, inputs, ... }: {
  gtk = {

    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";
    cursorTheme.size = 18;

    iconTheme.package = pkgs.candy-icons;
    iconTheme.name = "candy-icons";

    theme.name = "adw-gtk3";
    theme.package = pkgs.adw-gtk3;

    font = {
      name = "Fira Sans";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}
