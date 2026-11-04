{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nix-tree
    ripgrep
    atuin
    fastfetch
    starship
    unzip
    fd
    termdown
    fzf
    wl-clipboard
  ];
}
