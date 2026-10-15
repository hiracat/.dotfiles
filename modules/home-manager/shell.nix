{ config, ... }: {
  programs.bash = {
    enable = true;
  };
  home.sessionPath = [ "$HOME/.cargo/bin" ];
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      save = 10000;
      size = 10000;
      path = "${config.home.homeDirectory}/.histfile";
    };

    initContent = ''
      export GEM_HOME="$HOME/gems"
      export PATH="$HOME/gems/bin:$PATH"

      # apply the matugen palette to the linux virtual console. only meaningful on a
      # real TTY -- graphical terminals get their colors from their own config.
      if [ "$TERM" = "linux" ] && [ -r "$HOME/.config/console/colors.sh" ]; then
        . "$HOME/.config/console/colors.sh"
      fi

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
