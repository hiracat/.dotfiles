{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writeScriptBin "rb" ''
      #!${pkgs.python3}/bin/python3
    '')
  ];
}
