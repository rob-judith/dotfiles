# Some settings are OS dependent.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls="ls --color=auto"

elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -G"
  export EDITOR="VIM"
else
  echo "Unrecognized OS some settings not set."
fi

export PIP_REQUIRE_VIRTUALENV=true
export EDITOR="/usr/bin/vim"

alias ll="ls -l"
alias la="ls -a"

# Tmux aliases
alias tmuxa="tmux a -t"
alias tmuxs="tmux new-session -s"
