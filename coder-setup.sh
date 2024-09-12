#!/bin/bash
sudo apt-get install -y fish fzf ripgrep tmux fd-find
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs
sudo snap install nvim --classic
curl https://pyenv.run | bash


fish -c "alias fd='fdfind'; funcsave fd"
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths"
# Set a path for custom scripts
fish -c "set -U fish_user_paths $HOME/dotfiles/bin"


# Configre dcvserver and nvidia
sudo apt install -y $(nvidia-detector) gnome
sudo nvidia-xconfig
sudo systemctl start gdm
sudo systemctl restart dcvserver
