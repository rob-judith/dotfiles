# Start fish if this is an SSH session and if fish is installed
# This is safer for coder machines than changing the login shell
# which can break scripts
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if [ -n "$SSH_TTY" ] && command -v fish > /dev/null; then
    SHELL=$(which fish) exec fish
fi

