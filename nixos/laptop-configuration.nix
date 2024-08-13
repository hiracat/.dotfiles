{ systemSettings, ... }: {

  networking = {
    hostName = systemSettings.laptopHostname;
  };
}
