{ pkgs, config }: {

  programs.git = {
    enable = true;
    userName = "forest";
    userEmail = "hiracat@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
      push.default = "simple";
    };
  };
}
