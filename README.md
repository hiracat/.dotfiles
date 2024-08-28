# Hiracats Dotfiles

## About
This is my personal NixOS config built with Nix flakes. It's straightforward and easy to understand—no fancy modules or complicated stuff.
I kept it simple with basic Nix syntax. Feel free to use it, tweak it, or even rip it off. If you want to give me credit, that'd be awesome, but no worries if you don't.
The setup mainly uses Home Manager and base16-nix, without any of the heavy stuff like declarative disk management or impermanence.nix.
It uses Hyprland as the window manager, Waybar as the bar, and Rofi as the launcher. I use GTK apps for most things, so QT is not themed yet.

### What’s Inside

- **Theme Management**:
  - Base16 themes applied to everything—GTK, Waybar, Kitty, Cava, Dunst, the TTY, and even Obsidian vaults.
  - A handy theme manager script lets you switch between 300+ themes from the Base16 repos with one command.
  - Random wallpaper picker included for some variety.

- **Customization**:
  - Easy to adapt for different devices, thanks to its modular (but not perfect) structure.
  - FCITX5 is set up for Japanese input with Mozc.
  - Caps Lock and Escape keys are swapped—tap for Escape, hold for Control.
  - Includes a pretty sweet Neovim setup, but you can ditch it if it’s not your thing. Just keep the `lifecolor.lua` script; it’s great for switching themes on the fly.
  - Most themes are Catppuccin-based, with Base16 color tweaks.

- **Helper Scripts**:
  - A simple script to rebuild your config. You'll need it to apply themes everywhere, even after a reboot (especially for Neovim).

---

## How to Install

1. **Clone the repo:**
   ```sh
   git clone https://github.com/hiracat/.dotfiles ~/.dotfiles
   ```

2. **Set up your NixOS config:**
   - Import your device’s `hardware-configuration.nix`.
   - Bring in the other necessary files and edit them as you like.
   - Make sure to remove my configurations and create a new one using your devices hostname, as the rebuild command uses that.

3. **Go to the directory:**
   ```sh
   cd ~/.dotfiles
   ```

4. **Run these commands:**
   ```sh
   sudo nixos-rebuild switch --flake .
   rebuild switch # Provided by my dotfiles
   ```

---

## How to Use

1. **Rebuild and switch to new config**
   ```sh
   rebuild switch
   ```

2. **Rebuild and switch to the new config without adding it to the boot menu**
   ```sh
   rebuild test
   ```

3. **Switch Wallpaper**
   ```sh
   thememanager wallpaper <wallpapername/random>
   ```

3. **Switch Theme**
   ```sh
   thememanager theme <themename>
   ```

find all the themes [here](https://tinted-theming.github.io/base16-gallery/)

## Contributing
PRs are welcome, especially if they simply improve something that already exits or adds a missing feature.
Issues are also welcome, and if you are a nix beginner I might even help you out with something that you need, but I am a beginner myself.
