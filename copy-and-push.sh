#!/bin/bash

# Define your dotfiles you want to copy
declare -a DOTFILES=(
    "~/.bashrc"
    "~/.vimrc"
    "~/.gitconfig"
    "~/.zshrc"
    "~/.bashrc.d"
    "~/.xinitrc"
    "~/.taskrc"
    "~/.profile"
    "~/.config/tmux/*.conf"
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

for PATTERN in "${DOTFILES[@]}"; do
    # Use find to expand patterns
    for FILE in $(eval "find $(dirname "$PATTERN") -maxdepth 1 -name '$(basename "$PATTERN")'"); do
        if [ -f "$FILE" ]; then
            cp -u "$FILE" "$DEST_DIR/"
            echo "Copied file $FILE to $DEST_DIR/"
        elif [ -d "$FILE" ]; then
            # If it's a directory, copy the contents recursively
            cp -ur "$FILE/" "$DEST_DIR/"
            echo "Copied directory $FILE to $DEST_DIR/"
        fi
    done

    # Handle empty directory case
    if [[ -d "$PATTERN" && ! -d "$DEST_DIR/$(basename "$PATTERN")" ]]; then
        echo "Warning: Directory $PATTERN is empty and was not copied."
    fi
done

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
