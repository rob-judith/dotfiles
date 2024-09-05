#!/bin/bash

CLONE_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"
REPO_URL="git@github.com:rob-judith/dotfiles.git"


git clone "$REPO_URL" "$CLONE_DIR"
mkdir "$BACKUP_DIR"

echo "Configuring dotfiles"

# Initialize and update submodules (for Tmux plugins or other submodule-managed configurations)
cd "$CLONE_DIR"
git submodule update --init --recursive
cd "$HOME"

# Create symlinks for dotfiles
DOTFILES=("vimrc" "tmux.conf" "gitconfig" "bashrc" "gitignore" "bash_profile")
for file in "${DOTFILES[@]}"; do
    mv "$HOME/.$file" "$BACKUP_DIR/$file"
    ln -s "$CLONE_DIR/$file" "$HOME/.$file"
done

# Symlink fish config (assuming your config is in a directory named ".config/fish")
if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
fi
if [ ! -d "$HOME/.config/fish" ]; then
    mkdir "$HOME/.config/fish"
fi
mv "$HOME/.config/fish/config.fish" "$BACKUP_DIR/config.fish"
ln -s "$CLONE_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"

if [ ! -d "$HOME/.config/nvim" ]; then
    mkdir "$HOME/.config/nvim"
else 
    mv "$HOME/.config/nvim/init.lua" "$BACKUP_DIR/init.lua"
fi
ln -s "$CLONE_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -s "$CLONE_DIR/nvim/lua" "$HOME/.config/nvim/lua"
# Symlink starship toml
ln -s "$CLONE_DIR/starship.toml" "$HOME/.config/starship.toml"


# Create symlinks for dot folders
for folder in "tmux" "vim"; do
    # Remove simlink if it exists
    if [ -L "$HOME/.$folder" ]; then
        rm "$HOME/.$folder"
    fi
    if [-d "$HOME/.$FOLDER" ]; then
        mv "$HOME/.$folder" "$BACKUP_DIR/$folder"
    fi
    ln -s "$CLONE_DIR/$folder/" "$HOME/.$folder"
done

# Install Vim plugins
vim +PlugInstall +qall
echo "Dotfiles and plugins installed"
