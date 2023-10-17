# Some settings are OS dependent.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls="ls --color=auto --group-directories-first"
  export EDITOR="/usr/bin/vim"

elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="gls --color=auto --group-directories-first"
  export EDITOR="/usr/local/bin/vim"
  # setup bash_completion this will fail if brew isn't installed
  . `brew --prefix`/etc/bash_completion
else
  echo "Unrecognized OS some settings not set."
fi

# Don't let me install python packages without a virtual env
export PIP_REQUIRE_VIRTUALENV=false

# Define Colors
# dark colors
DK=$'\033[0;30m'    # black
DR=$'\033[0;31m'    # red
DG=$'\033[0;32m'    # green
DY=$'\033[0;33m'    # yellow
DB=$'\033[0;34m'    # blue
DM=$'\033[0;35m'    # magenta
DC=$'\033[0;36m'    # cyan
DW=$'\033[0;37m'    # white
# light colors
LK=$'\033[1;30m'    # black
LR=$'\033[1;31m'    # red
LG=$'\033[1;32m'    # green
LY=$'\033[1;33m'    # yellow
LB=$'\033[1;34m'    # blue
LM=$'\033[1;35m'    # magenta
LC=$'\033[1;36m'    # cyan
LW=$'\033[1;37m'    # white
ENDCOLOR=$'\033[0m'  # End color

# Set Colors thanks Josesph
export LSCOLORS=ExFxBxDxCxegedabagacad # specifies colors for mac
export LS_COLORS=$LS_COLORS:'di=1;34:ln=36:*.py=31:*.txt=33:*.ipynb=35:*.csv=33' # specifies colors for linux

alias start_fish="SHELL=/usr/bin/fish fish"

eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
