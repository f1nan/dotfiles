#!/usr/bin/env bash

DOTFILES=(vimrc)
BACKUP_DIR="$HOME"/dotfiles_old

backup_existing_dotfiles()
{
    echo "Backup existing dotfiles in $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    local file
    for file in ${DOTFILES[@]}; do
        mv "$HOME/.$file" "$BACKUP_DIR" 2>/dev/null
    done
}

make_symlinks()
{
    echo "Create symlinks for ${DOTFILES[@]} in $HOME"

    local file
    for file in "${DOTFILES[@]}"; do
        ln -s "$(pwd)/$file" "$HOME/.$file"
    done
}

main()
{
    backup_existing_dotfiles
    make_symlinks
}

main "$@"
