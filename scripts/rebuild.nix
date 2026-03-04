{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writeScriptBin "rb" builtins.readFile ./rb.py)
  ];
}
