{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern";
    cursorTheme.size = 16;

    # catppuccin.enable = true;

    iconTheme.package = pkgs.candy-icons;
    iconTheme.name = "candy-icons";

    font = {
      name = "Fira Sans";
      size = 12;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
