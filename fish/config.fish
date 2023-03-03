pyenv init - | source
# We don't want fancy setup for emacs
if [ "$TERM" != "dumb" ]
    starship init fish | source
end

# Created by `pipx` on 2022-08-15 15:02:37
set PATH $PATH /home/robjudith/.local/bin
