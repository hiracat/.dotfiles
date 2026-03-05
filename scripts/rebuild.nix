{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writers.writePython3Bin "rb"
      {
        flakeIgnore = [ "E" "W" "F" ];
      }
      (builtins.readFile ./rb.py))

  ];
}
