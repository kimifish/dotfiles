#!/bin/bash

# Define your dotfiles you want to copy
declare -a DOTFILES=(
    ".bashrc"
    ".vimrc"
    ".gitconfig"
    ".zshrc"
    ".bashrc.d"
    ".xinitrc"
    ".taskrc"
    ".profile"
    ".tmuxinator"
    ".bash_logout"
    ".fzf.bash"
    ".fzf.zsh"
    ".gtkrc-2.0"
    ".ideavimrc"
    ".nvidia-settings-rc"
    ".config/tmux/*.conf"
    ".config/nvim/init.lua"
    ".config/nvim/lua/base/"
    ".config/nvim/lua/plugins/"
    ".config/nvim/lua/lsp/"
    ".config/i3"
    ".config/i3blocks"
    ".config/rofi/*"
    ".config/autorandr"
    ".config/clipcat"
    ".config/dunst"
    ".config/fish"
    ".config/gtk-3.0"
    ".config/htop"
    ".config/kitty"
    ".config/lazygit"
    ".config/ncmpcpp/bindings"
    ".config/qt5ct"
    ".config/vifm/colors"
    ".config/vifm/scripts"
    ".config/vifm/vifmrc"
    ".config/user-dirs.dirs"
    ".config/user-dirs.locale"
    ".config/pulsemixer.cfg"
    ".config/mimeapps.list"
    # Add more dotfiles as needed
)

# Destination directory
DEST_DIR="$HOME/.config/dotfiles"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy dotfiles to the destination directory
# for FILE_R in "${DOTFILES[@]}"; do
#     FILE="$HOME/$FILE_R"
#     # Check if the file exists in the home directory
#     if [ -f "$FILE" ]; then
#         cp -u "$FILE" "$DEST_DIR/"
#         echo "Copied $FILE to $DEST_DIR/"
#     else
#         echo "Warning: $FILE does not exist and was not copied."
#     fi
# done

# Copy dotfiles and directories to the destination directory
for PATT in "${DOTFILES[@]}"; do
    PATTERN="$HOME/$PATT"
    REL_PATH="$(dirname "$PATT")"
    # Use find to expand patterns
    echo "PATTERN: $PATTERN"
    echo "REL_PATH: $REL_PATH"
    eval_string="find $(dirname "$PATTERN") -maxdepth 1 -name '$(basename "$PATTERN")'"
    # for FILE in $(eval "find $(dirname "$PATTERN") -name '$(basename "$PATTERN")'"); do
    for FILE in $(eval "$eval_string"); do
        echo "ORIGIN: $FILE"
        if [ -f "$FILE" ]; then
            # Determine the relative path to maintain directory structure
            DEST_PATH="$DEST_DIR/$REL_PATH/$(basename "$FILE")"
            echo "DEST_PATH: $DEST_PATH"
            # Create the destination directory if it doesn't exist
            mkdir -p "$(dirname "$DEST_PATH")"
            cp -u "$FILE" "$DEST_PATH"
            echo "Copied file $FILE to $DEST_PATH"
        elif [ -d "$FILE" ]; then
            # Copy the entire directory while preserving structure
            cp -ur "$FILE" "$DEST_DIR/$REL_PATH/"
            echo "Copied directory $FILE to $DEST_DIR/"
        fi
    done
done
    # Handle empty directory case
#     if [[ -d "$PATTERN" && ! -d "$DEST_DIR/$(basename "$PATTERN")" ]]; then
#         echo "Warning: Directory $PATTERN is empty and was not copied."
#     fi
# done

# Change to the dotfiles directory
cd "$DEST_DIR" || { echo "Failed to change directory to $DEST_DIR"; exit 1; }

# Check if there are changes to commit
if ! git diff-index --quiet HEAD --; then
    # Stage the changes for commit
    git add .

    # Commit changes with a message
    git commit -m "Update dotfiles on $(date +'%Y-%m-%d %H:%M:%S')"

    # Push changes to the remote repository
    git push -u origin master # Change 'main' to your default branch if different
else
    echo "No changes to commit."
fi
