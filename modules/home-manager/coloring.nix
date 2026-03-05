{ inputs, config, ... }:
let
  dotfiles_dir = "/home/${config.home.username}/.dotfiles";
in

{
  xdg.configFile."matugen/config.toml".text = ''
    [config]

    [templates.waybar]
    input_path = "${dotfiles_dir}/templates/waybar_colors.css"
    output_path = "~/.config/waybar/colors.css"
    post_hook = "pkill -SIGUSR2 waybar || true"

    [templates.cava]
    input_path = "${dotfiles_dir}/templates/cava.conf"
    output_path = "~/.config/cava/config"
    post_hook = "pkill --signal SIGUSR2 cava || true"

    [templates.kitty]
    input_path = "${dotfiles_dir}/templates/kitty_theme.conf"
    output_path = "~/.config/kitty/theme.conf"
    post_hook = "pkill --signal SIGUSR1 kitty || true"

    [templates.gtk3]
    input_path = "${dotfiles_dir}/templates/gtk_colors.css"
    output_path = "~/.config/gtk-3.0/colors.css"

    [templates.gtk4]
    input_path = "${dotfiles_dir}/templates/gtk_colors.css"
    output_path = "~/.config/gtk-4.0/colors.css"

    [templates.dunst]
    input_path = "${dotfiles_dir}/templates/dunst.conf"
    output_path = "~/.config/dunst/dunstrc"
    post_hook = "dunstctl reload"

    [templates.obsidian]
    input_path = "${dotfiles_dir}/templates/obsidian.css"
    output_path = "~/Documents/The Vault/.obsidian/snippets/base16.css"

    [templates.nvim]
    input_path = "${dotfiles_dir}/templates/nvim.lua"
    output_path = "~/.config/nvim/lua/forest/coloroverrides.lua"
  '';
}
