# Defined in /tmp/fish.PHSkvn/dcv-open.fish @ line 2
function dcv-open --wraps='DISPLAY=:1 GNOME_DESKTOP_SESSION_ID=0 xdg-open' --wraps=xdg-open --description 'alias dcv-open=DISPLAY=:1 GNOME_DESKTOP_SESSION_ID=0 xdg-open'
  DISPLAY=:1 GNOME_DESKTOP_SESSION_ID=0 xdg-open $argv;
end
