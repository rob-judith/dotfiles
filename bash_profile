if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls="ls --color=auto"
elif [[ "$OSTYPE" == "darwin15" ]]; then
  alias ls="ls -G"
else
  echo "Unrecognized OS some settings not set."
fi

alias ll="ls -l"
alias la="ls -a"
