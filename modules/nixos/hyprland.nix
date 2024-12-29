{ ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  programs.zsh.loginShellInit = ''
    if uwsm check may-start && uwsm select; then
      exec systemd-cat -t uwsm_start uwsm start default
    fi
  '';

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
