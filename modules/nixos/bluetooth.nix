{ ... }: {
  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=0
  '';
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
