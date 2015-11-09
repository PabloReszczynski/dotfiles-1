# delete all keybindings
unbind -a

# use ^a as prefix
set -g prefix '^a'

# use ^aa for sending ^a
bind 'a' send-prefix

# misc bindings
bind ':' command-prompt
bind '^r' source ~/.tmux.conf
bind '^l' refresh-client

bind 'PageUp' copy-mode -u
bind 'PageDown' copy-mode

bind 'D' detach

set -g status-keys 'vi'
set -g mode-keys 'vi'

# panel
set -g status-interval 1

set -g status-style 'bg=black,fg=white'
set -g status-left-style 'bg=black,fg=white'
set -g status-right-style 'bg=black,fg=white'

set -g status-left ''
set -g status-left-length 0
#set -g status-left-style

set -g status-right '%T'
set -g status-right-length 10
#set -g status-right-style


set -g window-status-format '#I:#W'
set -g window-status-style 'bg=black,fg=THEME_COLOR'

set -g window-status-current-format '#I:#W'
set -g window-status-current-style 'bg=black,fg=white,bold'

set -g window-status-last-style 'bg=black,fg=white'
set -g window-status-bell-style 'bg=black,fg=red'

#set -g default-terminal "screen-256color"

# don't cut the window down to the smallest
# session, use seperate windows instead
set -g aggressive-resize on

# pane control
bind -r 'M-h' resize-pane -L
bind -r 'M-j' resize-pane -D
bind -r 'M-k' resize-pane -U
bind -r 'M-l' resize-pane -R

# pane selection
bind -r 'H' select-pane -L
bind -r 'J' select-pane -D
bind -r 'K' select-pane -U
bind -r 'L' select-pane -R

# window selection
bind '"' choose-window
bind '`' run -b '~/.tmux/bin/approx_window_switch.pl 0'
bind '1' run -b '~/.tmux/bin/approx_window_switch.pl 1'
bind '2' run -b '~/.tmux/bin/approx_window_switch.pl 2'
bind '3' run -b '~/.tmux/bin/approx_window_switch.pl 3'
bind '4' run -b '~/.tmux/bin/approx_window_switch.pl 4'
bind '5' run -b '~/.tmux/bin/approx_window_switch.pl 5'
bind '6' run -b '~/.tmux/bin/approx_window_switch.pl 6'
bind '7' run -b '~/.tmux/bin/approx_window_switch.pl 7'
bind '8' run -b '~/.tmux/bin/approx_window_switch.pl 8'
bind '9' run -b '~/.tmux/bin/approx_window_switch.pl 9'
bind '0' run -b '~/.tmux/bin/approx_window_switch.pl 10'
bind '-' run -b '~/.tmux/bin/approx_window_switch.pl 11'
bind '=' run -b '~/.tmux/bin/approx_window_switch.pl 12'
bind 'BSpace' run -b '~/.tmux/bin/approx_window_switch.pl 13'
bind 'Home'   run -b '~/.tmux/bin/approx_window_switch.pl 14'
bind 'End'    run -b '~/.tmux/bin/approx_window_switch.pl 15'

bind '/' command-prompt "find-window -TN %%"
bind 'R' move-window -r

bind '^a' last-window
bind 'j'  previous-window
bind 'k'  next-window

# window creation and command execution
bind 'c' new-window
bind 'o' neww 'runner -H ~/.tmux/url_hist  -C -t "$HOME/.tmux/bin/w3m_openurl" -P url'
bind 's' neww 'runner -H ~/.tmux/srch_hist -C -t "$HOME/.tmux/bin/websearch" -P srch'
bind 'n' neww "runner -H ~/.tmux/cmd_hist -P cmd"
bind 'r' neww "runner -H ~/.tmux/cmd_hist -b -q -P cmd"

# vim: set filetype=tmux.conf:
