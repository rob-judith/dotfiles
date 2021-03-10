source ~/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle poetry
antigen bundle pyenv
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply

# Aliases
alias open=xdg-open
alias jkernels-list="jupyter kernelspec list"
alias jkernels-remove="jupyter kernelspec remove"
alias jkernels-install="ipython kernel install --user --name"
alias venv-activate="source ./venv/bin/activate"

# Functions

# Path and computer specific setup goes in the main zshrc

