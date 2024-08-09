{ pkgs, ... }: {

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "rebuild";
      runtimeInputs = [ ];
      text = ''
              set -e
        set +o nounset

        args=""
        if [ -z "$1" ]; then
            echo "usage: rebuild <test/switch> <full>"
            exit 1
        else
            if [ "$1" = "test" ]; then
                args+='test '
            elif [ "$1" = "switch" ]; then
                args+='switch '
            else
                echo "usage: rebuild <test/switch> <full>"
                exit 1
            fi

            if [ -z "$2" ]; then
                args+=" --fast "
            else
                if [ "$2" = "full" ]; then
                    args+=""
                fi
            fi
        fi

        rebuildcmd="sudo nixos-rebuild $args --flake ~/.dotfiles -j 6"
        echo "running command: $rebuildcmd"
        eval "$rebuildcmd"
        echo "rebuild system"

        pkill --signal SIGUSR1 kitty || true
        pkill --signal SIGUSR2 cava || true
        pkill --signal SIGUSR2 waybar || true
        echo "sent signals"

        pkill dunst || true
        dunst >/dev/null 2>&1 & #TODO: replace with dunstctl reload one that update comes out
        echo "restarted programs"

        cat ~/.cache/colorschemes/nvimcolors.lua >~/.config/nvim/lua/forest/coloroverrides.lua
        echo "wrote files"

        gsettings set org.gnome.desktop.interface gtk-theme ""
        sleep .1
        gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
        echo "reloaded gtk"
        echo "finished"

      '';
    }
    )
  ];
}
