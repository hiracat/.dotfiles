{ systemSettings, ... }: {
  networking = {
    hostName = systemSettings.hostname;
  };
}
