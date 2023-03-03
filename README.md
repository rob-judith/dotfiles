This is a repo for all of my configuration files. Anyone can use this if they would like but it's not designed to be useful for others.

## VIM

Setup VIM with symbolic links.

```sh
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

## Emacs Doom

```
ln -s ~/dotfiles/doom.d ~/.doom.d
```

### Fish

I've started to use fish as my main fancy prompt. Ad the following two lines to the `.config/fish/config.fish` file.

Functions by default will be machine specific but can be copied over to the dot files. This let's me have machine specific aliases.

```sh
source ~/dotfiles/fish/config.fish
set fish_function_path $fish_function_path ~/dotfiles/fish/functions
```

### bash

In addition to sourcing the bash profile you have to source the `git-prompt-sh` script.

```sh
echo -e "source /usr/lib/git-core/git-sh-prompt\nsource ~/.dotfiles/bash_profile\nsource ~/dotifles/aliases\n$(cat ~/.bashrc)" > ~/.bashrc
```

If I use both shells on a machine, I like to put the shared env variables into a `~/.shell_shared` file.

### Tmux config

```bash
echo -e "source-file ~/.dotfiles/tmux.conf\n$(cat ~/.tmux.conf)" > ~/.tmux.conf
```
