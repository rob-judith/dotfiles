set -U fish_greeting
if [ "$TERM" != "dumb" ]
    starship init fish | source
end
