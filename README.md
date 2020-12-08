This is a repo for all of my configuration files. Anyone can use this if they would like but it's not designed to be useful for others.


Setup VIM with symbolic links.

```bash
ln -s ~/.dotfiles/vim/ ~/.vim
ln -sf ~/.dotfiles/vim/vimrc ~/.vimrc
```

Point git to the repo files in `.gitconfig`:

```
[include]
    path = "~/.dotfiles/gitconfig"

[core]
    excludesfile = "~/.dotfiles/gitignore"
```

For shells.

Clone the antigen repo and source the zshrc file

```bash
git clone git@github.com:zsh-users/antigen.git ~/.antigen
source ~/.dotfiles/zshrc
```
