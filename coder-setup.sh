#!/bin/bash

if test ! $(which brew); then
echo "Homebrew not found. Installing..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Update Homebrew recipes
brew update

# Install the tools
brew install fish fzf ripgrep tmux starship fd nvim cmake node

fish -c "alias fd='fdfind'; funcsave fd"
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv"
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; fish_add_path $PYENV_ROOT/bin"
# Set a path for custom scripts
fish -c "set -U fish_user_paths $HOME/dotfiles/bin"


# Configre dcvserver and nvidia
sudo apt install -y $(nvidia-detector) gnome
sudo nvidia-xconfig
sudo systemctl start gdm
sudo systemctl restart dcvserver
