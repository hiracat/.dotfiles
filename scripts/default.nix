{ pkgs, ... }: {

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "rebuild";
      runtimeInputs = [ ];
      text = ''
        set -e
        set +o nounset
        if [ -z "$1" ]; then
          echo "usage: rebuild <test/switch>"
          exit 1
        fi
        sudo nixos-rebuild "$1" --flake ~/.dotfiles -j 6
        kill -s SIGUSR1 $(pgrep kitty) > /dev/null # reloads kitty config
        pkill waybar && waybar > /dev/null 2>&1 &
        cat ~/.cache/colorschemes/nvimcolors.lua > ~/.config/nvim/lua/forest/coloroverrides.lua
        pkill dunst && dunst > /dev/null 2>&1 &
      '';
    }
    )
  ];
}
