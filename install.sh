#!/usr/bin/env bash

DOTFILES=(vimrc vim/)
BACKUP_DIR="$HOME/dotfiles_$(date +%Y%m%d_%H%M%S)"
PWD=$(pwd)

echo "Backup existing dotfiles..."
mkdir -p "$BACKUP_DIR"
for file in ${DOTFILES[@]}; do
    mv "$HOME/.$file" "$BACKUP_DIR" 2>/dev/null
done

echo "Install dotfiles..."
for file in "${DOTFILES[@]}"; do
    cp -r "$PWD/$file" "$HOME/.$file"
done
