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
bind '`' select-window -t :0
bind '1' select-window -t :1
bind '2' select-window -t :2
bind '3' select-window -t :3
bind '4' select-window -t :4
bind '5' select-window -t :5
bind '6' select-window -t :6
bind '7' select-window -t :7
bind '8' select-window -t :8
bind '9' select-window -t :9
bind '0' select-window -t :10
bind '-' select-window -t :11
bind '=' select-window -t :12
bind 'BSpace' select-window -t :13
bind 'Home' select-window -t :14

bind '/' command-prompt "find-window -TN %%"
bind 'R' move-window -r

bind '^a' last-window
bind 'j' previous-window
bind 'k' next-window

# window creation and command execution
bind 'c' new-window
bind 'o' neww '~/.tmux/bin/complread -c "$HOME/.tmux/bin/w3m_openurl" -P url'
bind 's' neww '~/.tmux/bin/complread -c "$HOME/.tmux/bin/websearch" -P srch'
bind 'n' neww "~/.tmux/bin/complread -s -P cmd"
bind 'r' neww "~/.tmux/bin/complread -b -P cmd"

# vim: set filetype=tmux.conf:
