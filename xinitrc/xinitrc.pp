#!/bin/bash

WindowManager=openbox

run() {
    "$@" &>/dev/null&
}

has() {
   which "$1" &>/dev/null
}

{
   mkdir -p "/tmp/$USER."{adobe,macromedia}
   mkdir -p "/tmp/$USER.mozilla."{develop2,norm}
   mkdir -p "/tmp/$USER.downloads"

   [[ -e ~/.Xresources ]]  && xrdb -merge ~/.Xresources
   [[ -e ~/.Xmodmap ]]     && xmodmap ~/.Xmodmap
   [[ -e ~/.xbindkeysrc ]] && xbindkeys

   xsetroot -solid '#000001' # hack for fucking flash player

   has nitrogen && run nitrogen --restore

   has xscreensaver && run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))

   if has tmux; then
      if ! tmux has-session; then
         tmux new-session -d -s 0
         has ncmpcpp && tmux new-window -d ncmpcpp
         has mcabber && tmux new-window -d mcabber
         has mutt    && tmux new-window -d mutt
         has w3m     && tmux new-window -d w3m http://blog.fefe.de
         has vim     && tmux new-window -d vim
         has htop    && tmux new-window -d htop
         tmux new-window
      fi

      terminal_init="tmux attach"
   elif has zsh; then
      terminal_init="zsh"
   else
      terminal_init="bash"
   fi

   if has evilvte; then
      evilvte -e $terminal_init
   elif has xterm; then
      xterm -e $terminal_init
   fi

#> if "HOST" eq "pizwo"
   has mpd && run mpd
   has synergys && run synergys
    #xscreensaver-command -lock
#> elif "HOST" eq "samsung"
   has synergyc && run synergyc 10.0.0.10
#> endif

} &

exec $WindowManager

