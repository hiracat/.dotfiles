{ ... }: {

  programs.git = {
    enable = true;
    settings = {
      user.name = "hiracat";
      user.email = "hiracat@proton.me";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      push.default = "simple";
      credential."https://github.com".helper = "!/run/current-system/sw/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "!/run/current-system/sw/bin/gh auth git-credential";
      aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      };
    };
  };
}
