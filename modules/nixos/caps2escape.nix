{ pkgs-stable, ... }: {
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs-stable.interception-tools-plugins.caps2esc ];
    udevmonConfig = ''
      - JOB: "${pkgs-stable.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs-stable.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs-stable.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };
}
