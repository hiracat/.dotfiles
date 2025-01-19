{ ... }: {

  programs.git = {
    enable = true;
    userName = "forest";
    userEmail = "hiracat@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      push.default = "simple";
      credential."https://github.com".helper = "!/run/current-system/sw/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "!/run/current-system/sw/bin/gh auth git-credential";
    };
  };
}
