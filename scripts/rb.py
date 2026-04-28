import subprocess
import sys
import os
import random

def notify(msg):
    subprocess.run(["notify-send", msg], check=False)

def usage():
    print("Usage:")
    print("ommiting the theme or wallpaper will open tofi")
    print("  rb sw <fast>   - rebuild switch, fast uses the --fast flag")
    print("  rb theme <themename>    - set theme and rebuild")
    print("  rb wall <wallpapername>    - change wallpaper and theme based on the wallpaper and rebuild")
    sys.exit(1)

def nixos_rebuild(subcmd):
    hostname = subprocess.check_output(["hostname"]).decode().strip()
    home = os.path.expanduser("~")

    cmd = f"sudo nixos-rebuild {subcmd} --flake {home}/.dotfiles#{hostname} -j 6"

    print(f"running command: {cmd}")
    notify(f"running command: {cmd}")

    subprocess.run(cmd, shell=True, check=True)

    print("rebuilt system")
    notify("Finished")

def select_random_image(wallpaper_dir):
    if not os.path.isdir(wallpaper_dir):
        print(f"Folder not found: {wallpaper_dir}, please create it", file=sys.stderr)
        sys.exit(1)

    files = []
    for f in os.listdir(wallpaper_dir):
        full_path = os.path.join(wallpaper_dir, f)
        if os.path.isfile(full_path):
            files.append(full_path)

    if not files:
        print(f"No wallpapers found in {wallpaper_dir}, please add some", file=sys.stderr)
        sys.exit(1)

    try:
        result = subprocess.check_output(["awww", "query"]).decode()
        current = result.split("image: ")[-1].strip()
    except Exception:
        current = None

    choices = [f for f in files if f != current]
    if not choices:
        choices = files

    return random.choice(choices)

def cmd_wall(args):
    home = os.path.expanduser("~")
    wallpaper_dir = os.path.join(home, ".dotfiles/assets/wallpapers")
    if len(args) == 0:
        files = os.listdir(wallpaper_dir)
        listing = "\n".join(files)
        result = subprocess.run(["tofi"], input=listing, capture_output=True, text=True)
        selected = result.stdout.strip()
        image = os.path.join(wallpaper_dir, selected)

    elif args[0] == "random":
        image = select_random_image(wallpaper_dir)
    else:
        image = None
        for f in os.listdir(wallpaper_dir):
            if os.path.splitext(f)[0] == os.path.splitext(args[0])[0]:
                image = os.path.join(wallpaper_dir, f)
                break
        if image is None:
            print(f"Wallpaper not found: {args[0]}", file=sys.stderr)
            sys.exit(1)

    print(f"Selected wallpaper: {image}")
    subprocess.run(["awww", "img", image], check=True)
    return image

def cmd_theme(args):
    if not args:
        usage()
    theme = args[0]
    home = os.path.expanduser("~")
    print("todo: no themes available, need to add json and a themes directory")


def cmd_wallcolor(args):
    image = cmd_wall(args)
    subprocess.run(["matugen", "image", image, "--source-color-index", "0", "--type", "scheme-vibrant", "--verbose"], check=True)



def cmd_sw(args):
    nixos_rebuild("switch")


args = sys.argv[1:]
if not args:
    usage()

command = args[0]
rest = args[1:]

if command == "sw":
    cmd_sw(rest)
elif command == "theme":
    cmd_theme(rest)
elif command == "wallcolor":
    cmd_wallcolor(rest)
elif command == "wall":
    cmd_wall(rest)
else:
    usage()
