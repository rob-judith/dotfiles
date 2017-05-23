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
export PIP_REQUIRE_VIRTUALENV=true

alias em='emacsclient -t -a emacs'
alias ll="ls -lh"
alias la="ls -a"

# Grep color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Create parent directories automatically
alias mkdir='mkdir -pv'

# Make wget resume partial downloads.
alias wget='wget -c'

# Tmux aliases
alias tmuxa="tmux a -t"
alias tmuxs="tmux new-session -s"

# Clean pyc files
alias pycclean='find ./ -name "*.pyc" -delete'

#Make Project
alias mkproj='cookiecutter git@github.com:StuckAt7/SCL-cookiecutter.git --checkout rj_custom'

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

# Git status color
function git_color() {
    local git_status="$(git status 2> /dev/null)"
    
    # Add second catch for new git output
    if [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e $DY
    elif [[ $git_status =~ "Your branch is behind" ]]; then
        echo -e $DM
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo -e $DG
    else 
        echo -en $DR
    fi
}

# Set bash line
# export PROMPT_DIRTRIM=2 #Trim bash
export PS1="\[$DC\]\u@\h\[$ENDCOLOR\] :: \[$DB\]\w\[\$(git_color)\]\$(__git_ps1)\[$ENDCOLOR\]\n$ "


# Set Colors thanks Josesph
export LSCOLORS=ExFxBxDxCxegedabagacad # specifies colors for mac
export LS_COLORS=$LS_COLORS:'di=1;34:ln=36:*.py=31:*.txt=33:*.ipynb=35:*.csv=33' # specifies colors for linux
