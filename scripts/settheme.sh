#!/etc/profiles/per-user/forest/bin/zsh

if [ -z "$1" ]; then
    echo "Usage: $0 <color_scheme>"
    exit 1
fi

file_content=$(
    cat <<EOL
{ inputs, ... }: {
    colorScheme = inputs.nix-colors.colorSchemes."$1"
}
EOL
)

echo "$file_content" >~/.dotfiles/home-manager/theme.nix
