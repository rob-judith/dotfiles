#!/bin/bash
sudo apt-get install -y fish fzf ripgrep tmux fd-find
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs
sudo snap install nvim --classic
rsync -a /data/robjudith/backup/ $HOME


fish -c "alias fd='fdfind'; funcsave fd"
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths"
# Set a path for custom scripts
fish -c "set -U fish_user_paths $HOME/dotfiles/bin"
