# Limit number of processes ####################################################
ulimit -u 2000

# Disable history expansion ####################################################
#   "set +o histexpand" does not work, we use +H instead
set +H

# Redraw within TMUX:
trap 'eval $(resize)' WINCH

Sysd=/lib/systemd/system
