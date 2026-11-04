{ pkgs, ... }: {
  # prevents stutter by letting pipewire demand cpu time
  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    alsa-utils
  ];
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
