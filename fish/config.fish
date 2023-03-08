# We don't want fancy setup for emacs
if [ "$TERM" != "dumb" ]
    starship init fish | source
end
