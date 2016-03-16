if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls="ls --color=auto"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -G"
else
  echo "Unrecognized OS some settings not set."
fi

export EDITOR="VIM"
alias ll="ls -l"
alias la="ls -a"

# Tmux aliases
alias tmuxa="tmux a -t"
alias tmuxs="tmux new-session -s"
