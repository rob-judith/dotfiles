set -U fish_greeting
starship init fish | source

# Set colorscheme
set -U  fish_color_autosuggestion 555\x1ebrblack
set -U  fish_color_cancel \x2dr
set -U  fish_color_command blue
set -U  fish_color_comment red
set -U  fish_color_cwd green
set -U  fish_color_cwd_root red
set -U  fish_color_end green
set -U  fish_color_error brred
set -U  fish_color_escape brcyan
set -U  fish_color_history_current \x2d\x2dbold
set -U  fish_color_host normal
set -U  fish_color_host_remote yellow
set -U  fish_color_normal normal
set -U  fish_color_operator brcyan
set -U  fish_color_param cyan
set -U  fish_color_quote yellow
set -U  fish_color_redirection cyan\x1e\x2d\x2dbold
set -U  fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -U  fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -U  fish_color_status red
set -U  fish_color_user brgreen
set -U  fish_color_valid_path \x2d\x2dunderline
set -U  fish_pager_color_completion normal
set -U  fish_pager_color_description B3A06D\x1eyellow\x1e\x2di
set -U  fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -U  fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
set -U  fish_pager_color_selected_background \x2dr

# Setup editor
set -U EDITOR vim

# Setup new function folder
set -gx fish_function_path $fish_function_path ~/dotfiles/fish/functions

# Enable fzf binding
fzf_key_bindings

