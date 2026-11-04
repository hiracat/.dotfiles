{ pkgs, ... }: {
  # auto mount usb
  services.devmon.enable = true;
  # gnome virtual filesystem lets file managers access usbs and the trash
  services.gvfs.enable = true;
  # managing usb devices over dbus
  services.udisks2.enable = true;
  # support apple devices
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];

}
