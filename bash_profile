# Some settings are OS dependent.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls="ls --color=auto"

elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -G"
  export EDITOR="VIM"
  # setup bash_completion this will fail if brew isn't installed
  . `brew --prefix`/etc/bash_completion
else
  echo "Unrecognized OS some settings not set."
fi

# Don't let me install python packages without a virtual env
export PIP_REQUIRE_VIRTUALENV=true
export EDITOR="/usr/bin/vim"

alias ll="ls -l"
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

# Define Colors
# dark colors
DK=$'\e[0;30m'    # black
DR=$'\e[0;31m'    # red
DG=$'\e[0;32m'    # green
DY=$'\e[0;33m'    # yellow
DB=$'\e[0;34m'    # blue
DM=$'\e[0;35m'    # magenta
DC=$'\e[0;36m'    # cyan
DW=$'\e[0;37m'    # white
# light colors
LK=$'\e[1;30m'    # black
LR=$'\e[1;31m'    # red
LG=$'\e[1;32m'    # green
LY=$'\e[1;33m'    # yellow
LB=$'\e[1;34m'    # blue
LM=$'\e[1;35m'    # magenta
LC=$'\e[1;36m'    # cyan
LW=$'\e[1;37m'    # white
ENDCOLOR=$'\e[0m'  # End color

# Git status color
function git_color() {
    local git_status="$(git status 2> /dev/null)"
    
    if [[ ! $git_status =~ "working directory clean" ]]; then
        echo -en "$DR"
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e $DY
    elif [[ $git_status =~ "nothing to comit" ]]; then
        echo -e $DM
    else 
        echo -en "$DG"
    fi
}

# Set bash line
export PROMPT_DIRTRIM=2
export PS1="\[$DC\]\u@\h\[$ENDCOLOR\]:\[$DB\]\w\[\$(git_color)\]\$(__git_ps1)\[$ENDCOLOR\]:\$ "
