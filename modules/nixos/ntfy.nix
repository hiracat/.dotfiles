{ config, ... }: {

  services.ntfy-sh.enable = true;
  services.ntfy-sh.settings = {
    base-url = "http://${config.networking.hostName}";
    listen-http = ":80";
    upstream-base-url = "https://ntfy.sh";
  };
}
