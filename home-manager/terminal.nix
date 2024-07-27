{ userSettings, config, ... }:
let
  aliases = {
    ll = "ls -l";
    nv = "nvim";
    gc = ''f() { git add . && git commit -m "$1" && git push}; f'';
  };
in
{

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      save = 10000;
      size = 10000;
      path = "${config.home.homeDirectory}/.histfile";
    };

    initExtra = ''
      eval "$(starship init zsh)"
      eval "$(atuin init zsh)"
      clear
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "no-rc"; # disable features if desired here
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    theme = "Catppuccin-Mocha";
    font.name = userSettings.font;
    font.size = 12;
    font.package = userSettings.fontPkg;
    extraConfig = ''
        '';
  };
}
