#!/bin/sh

swww_schedule() {
    echo "swww img $1 && cp \$(echo \"\$(swww query)\" | awk -F'image: ' '{print \$2}') ~/.cache/current_wallpaper" | at -q c "$2"
}

select_random_image() {
    # get the current image path from swwww
    current_image=$(echo "$(swww query)" | awk -F'image: ' '{print $2}')
    folder_path=~/Pictures/wallpapers

    # if folder path is a folder
    if [ ! -d "$folder_path" ]; then
        echo "Folder not found: $folder_path, please provide a wallpapers folder" >&2
        return 1
    fi

    # get all the files ine the folder
    files=$(find "$folder_path" -type f)

    # check if there are any files in the folder
    if [ -z "$files" ]; then
        echo "No files found in $folder_path" >&2
        return 1
    fi

    # select a random image
    new_random_image=$(echo "$files" | shuf -n 1)

    # debug
    echo "current image: $current_image" >&2
    echo "new random image: $new_random_image" >&2

    # select a NEW random image
    while [ "$current_image" = "$new_random_image" ]; do
        new_random_image=$(echo "$files" | shuf -n 1)
        echo "current image in loop: $current_image" >&2
        echo "new random image in loop: $new_random_image" >&2
    done
    # output the selected image
    echo "$new_random_image"
}

# change wallpaper when script is run
swww img "$(select_random_image)"

# clear at jobs from last time in queue c
atq | awk '$6 = "c" {print $1}' | xargs atrm

# generate at jobs for each hour to switch wallpaper
for hour in {8..22}; do
    swww_schedule "$(select_random_image)" "${hour}:00"
done
cp $(echo "$(swww query)" | awk -F'image: ' '{print $2}') ~/.cache/current_wallpaper
