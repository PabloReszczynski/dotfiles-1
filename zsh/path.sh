export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/games:/opt"
[[ -d "$HOME/bin" ]] && PATH+=":$HOME/bin"
[[ -d "/usr/bin/core_perl" ]] && PATH+=":/usr/bin/core_perl"
# TODO: implement own if-file-exists-module?
