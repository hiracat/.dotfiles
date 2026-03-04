import subprocess
import sys
import os
import random

def notify(msg):
    subprocess.run(["notify-send", msg], check=False)

def usage():
    print("usage:")
    print("ommiting the theme or wallpaper will open tofi")
    print("  rb sw <fast>   - rebuild switch, fast uses the --fast flag")
    print("  rb theme <themename>    - set theme and rebuild")
    print("  rb wall <wallpapername>    - change wallpaper and theme based on the wallpaper and rebuild")
    sys.exit(1)

def nixos_rebuild(subcmd, fast=False):
    fast_flag = " --fast" if fast else ""
    hostname = subprocess.check_output(["hostname"]).decode().strip()
    home = os.path.expanduser("~")
    cmd = f"sudo nixos-rebuild {subcmd}{fast_flag} --flake {home}/.dotfiles#{hostname} -j 6"
    print(f"running command: {cmd}")
    notify(f"running command: {cmd}")
    subprocess.run(cmd, shell=True, check=True)
    print("rebuilt system")
    notify("Finished")

def select_random_image(wallpaper_dir):
    if not os.path.isdir(wallpaper_dir):
        print(f"Folder not found: {wallpaper_dir}, please create it", file=sys.stderr)
        sys.exit(1)
    files = [
        os.path.join(wallpaper_dir, f)
        for f in os.listdir(wallpaper_dir)
        if os.path.isfile(os.path.join(wallpaper_dir, f))
    ]
    if not files:
        print(f"No wallpapers found in {wallpaper_dir}, please add some", file=sys.stderr)
        sys.exit(1)
    if len(files) == 1:
        return files[0]
    try:
        result = subprocess.check_output(["swww", "query"]).decode()
        current = result.split("image: ")[-1].strip()
    except Exception:
        current = None
    choices = [f for f in files if f != current] or files
    return random.choice(choices)

def cmd_wall(args):
    # TODO: add your wallpaper logic here
    # available helpers:
    #   select_random_image(wallpaper_dir) - returns a random image path
    #   subprocess.run(["swww", "img", path]) - sets the wallpaper
    home = os.path.expanduser("~")
    wallpaper_dir = os.path.join(home, ".dotfiles/assets/wallpapers")
    image = select_random_image(wallpaper_dir)
    print(f"Selected wallpaper: {image}")
    # subprocess.run(["swww", "img", image], check=True)

def cmd_theme(args):
    if not args:
        usage()
    theme = args[0]
    home = os.path.expanduser("~")
    print("todo: no themes available")
    nixos_rebuild("switch")

def cmd_sw(args):
    fast = len(args) > 0 and args[0] == "fast"
    nixos_rebuild("switch", fast=fast)

args = sys.argv[1:]
if not args:
    usage()

command = args[0]
rest = args[1:]

if command == "sw":
    cmd_sw(rest)
elif command == "theme":
    cmd_theme(rest)
elif command == "wall":
    cmd_wall(rest)
else:
    usage()
