{ config, userSettings, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = userSettings.aliases;
  };
  programs.zsh = {
    enable = true;
    shellAliases = userSettings.aliases;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      save = 10000;
      size = 10000;
      path = "${config.home.homeDirectory}/.histfile";
    };

    initExtra = ''
      export GEM_HOME="$HOME/gems"
      export PATH="$HOME/gems/bin:$PATH"

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
}
