#!/bin/bash

# Check if Homebrew is installed, install if we don't have it
if test ! $(which brew); then
echo "Homebrew not found. Installing..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install the tools
brew install fish fzf ripgrep tmux starship fd nvim cmake node
# Setup pyenv with fish
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; fish_add_path $PYENV_ROOT/bin"
