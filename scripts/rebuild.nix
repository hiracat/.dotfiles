{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "rb";
      runtimeInputs = [ ];
      text = ''
        set -e
        set +o nounset

        args=""
        if [ -z "$1" ]; then
            echo "usage: rb <t(test)/sw(switch)> <fast>"
            exit 1
        else
            if [ "$1" = "t" ]; then
                args+='test '
            elif [ "$1" = "sw" ]; then
                args+='switch '
            else
                echo "usage: rb <t(test)/sw(switch)> <fast>"
                exit 1
            fi

            if [ -z "$2" ]; then
                args+=""
            else
                if [ "$2" = "fast" ]; then
                    args+=" --fast "
                fi
            fi
        fi


        rebuildcmd="sudo nixos-rebuild $args --flake ~/.dotfiles#$(hostname) -j 6"
        echo "running command: $rebuildcmd"
        notify-send "running command: $rebuildcmd"
        eval "$rebuildcmd"
        echo "rebuild system"

        pkill --signal SIGUSR1 kitty || true
        pkill --signal SIGUSR2 cava || true
        pkill --signal SIGUSR2 waybar || true

        # pkill dunst || true
        # dunst >/dev/null 2>&1 & #TODO: replace with dunstctl reload one that update comes out
        echo "restarted programs"

        cat ~/.cache/colorschemes/nvimcolors.lua >~/.config/nvim/lua/forest/coloroverrides.lua
        echo "wrote files"

        # gsettings set org.gnome.desktop.interface gtk-theme ""
        # sleep .1
        # gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
        # echo "reloaded gtk"
        echo "finished"
        notify-send "Finished"
      '';
    })
  ];
}
