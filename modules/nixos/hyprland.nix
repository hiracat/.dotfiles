{ ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  services.xserver.displayManager.gdm.enable = true;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
