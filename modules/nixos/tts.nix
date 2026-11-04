{ pkgs-stable, ... }: {
  environment.systemPackages = with pkgs-stable; [
    piper-tts
    espeak-ng # basic voices (robotic but works)
  ];
  services.speechd.enable = true;
}
