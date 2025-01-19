{ pkgs, ... }: {
  services = {
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
    gnome.gnome-keyring.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
  };


  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
