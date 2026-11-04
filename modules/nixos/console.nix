{ ... }: {
  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    config = {
      hwaccel = true;
      font-name = "JetBrains Mono";
      font-size = 14;
    };
  };
}
