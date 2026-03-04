{ config, pkgs, ... }:
let
  codelldbPath = builtins.toString (
    pkgs.vscode-extensions.vadimcn.vscode-lldb + "/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"
  );
in
{
  xdg.configFile = {
    "nvim" = {
      enable = true;
      source = ./nvim;
      recursive = true;
    };
  };
  home.sessionVariables = {
    CODELLDB_PATH = codelldbPath;
  };
}
