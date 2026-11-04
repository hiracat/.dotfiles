{ ... }: {
  programs.gamescope.enable = true;
  hardware.steam-hardware.enable = true; # adds udev rules for controllers
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
