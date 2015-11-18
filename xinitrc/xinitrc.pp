#!/bin/bash

WindowManager=openbox

run() {
    "$@" &>/dev/null&
}

has() {
   which "$1" &>/dev/null
}

{
   ### make some temporary directories
   mkdir -p "/tmp/$USER."{adobe,macromedia}
   mkdir -p "/tmp/$USER.mozilla."{develop2,norm}
   mkdir -p "/tmp/$USER.downloads"

   ### initialize X11-stuff
   [[ -e ~/.Xresources ]]  && xrdb -merge ~/.Xresources
   [[ -e ~/.Xmodmap ]]     && xmodmap ~/.Xmodmap
   [[ -e ~/.xbindkeysrc ]] && xbindkeys

   ### Set background to something like black
   # (hack for fucking flash player)
   xsetroot -solid '#000001'

   ### Set background image if available
   has nitrogen && run nitrogen --restore

   ### Begin our tmux session or simply spawn a shell
   if has tmux; then
      terminal_init="tmux attach"

      if ! tmux has-session; then
         tmux new-session -d -s 0
         has mcabber && tmux new-window -d mcabber
         has ncmpcpp && tmux new-window -d ncmpcpp
         has w3m     && tmux new-window -d w3m http://blog.fefe.de
         has vim     && tmux new-window -d vim
         has htop    && tmux new-window -d htop
      fi
   elif has zsh; then
      terminal_init="zsh"
   else
      terminal_init="bash"
   fi

   ### Start a terminal emulator
   if has evilvte; then
      evilvte -f -e $terminal_init
   elif has xterm; then
      xterm -fullscreen -e $terminal_init
   elif has terminator; then
      terminator -f -b -x $terminal_init
   fi

   ### Set up our screensaver
   has xscreensaver && run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))
   #xscreensaver-command -lock

   ### Finally run some applications
#> if "HOST" eq "pizwo"
   has mpd && run mpd
   has synergys && run synergys
#> elif "HOST" eq "samsung"
   has synergyc && run synergyc 10.0.0.10
#> endif

   ### Our notification daemon
   has dunst && run dunst

} &

exec $WindowManager

