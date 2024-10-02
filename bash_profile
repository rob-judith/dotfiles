# Start fish if this is an SSH session and if fish is installed
# This is safer for coder machines than changing the login shell
# which can break scripts
if [ -n "$SSH_TTY" ] && command -v fish > /dev/null; then
    SHELL=/usr/bin/fish exec fish
fi

source ~/.bashrc

. "$HOME/.cargo/env"
