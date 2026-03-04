{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "no-rc"; # disable features if desired here
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    font.name = "JetBrainsMono NF";
    font.size = 12;
    settings = {
      background_opacity = 0.7;
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
    };
    extraConfig = ''
      include theme.conf
    '';
  };
}
