#!/bin/bash

WindowManager=openbox
LogFile="/tmp/xinitrc.$USER.$$.$WindowManager.log"
LogFile="/dev/null"

run() {
    "$@" &>>"$LogFile" &
}

has() {
   which "$1" &>>"$LogFile"
}

{
   ### make some temporary directories
   {
      mkdir -p "/tmp/$USER."{adobe,macromedia}
      mkdir -p "/tmp/$USER.mozilla."{develop2,norm}
      mkdir -p "/tmp/$USER.downloads"
      mkdir -p "/tmp/$USER.cache"
   } &

   ### initialize X11-stuff
   [[ -e ~/.Xresources ]]  && xrdb -merge ~/.Xresources
   [[ -e ~/.Xmodmap ]]     && xmodmap ~/.Xmodmap
   [[ -e ~/.xbindkeysrc ]] && xbindkeys

   ### Set background to something like black
   # (hack for fucking flash player)
   xsetroot -solid '#000001'

   ### Set background image if available
   has nitrogen && run nitrogen --restore

   ### Select terminal emulator
   if has uxterm; then
      terminal_cmd=( uxterm -fullscreen -e )
   elif has xterm; then
      terminal_cmd=( xterm -fullscreen -e )
   elif has evilvte; then
      terminal_cmd=( evilvte -f -e )
   elif has terminator; then
      terminal_cmd=( terminator -f -b -x )
   fi

   ### Select terminal init
   if has tmux; then
      terminal_cmd+=( tmux attach )

      if ! tmux has-session; then
         tmux new-session -d -s 0
         #has mcabber && tmux new-window -d mcabber
         #has ncmpcpp && tmux new-window -d ncmpcpp
      fi
   elif has zsh; then
      terminal_cmd+=( zsh )
   else
      terminal_cmd+=( bash )
   fi

   ### Start terminal emulator
   run "${terminal_cmd[@]}"
   timeout 5 sudo renice -n -5 -p $! &

   ### Open browser
   if has dillo; then
      run dillo;
      timeout 5 sudo renice -n -5 -p $! &
   fi

   ### Set up our screensaver
   has xscreensaver && run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))
   #xscreensaver-command -lock

   ### Adjust key repeat time/delay
   xset r rate 260 50

   ### Finally run some applications
#> if "HOST" eq "pizwo"
   has mpd && run mpd
   has synergys && run synergys
#> elif "HOST" eq "samsung"
   has synergyc && run synergyc 10.0.0.10
#> endif

   ### Our notification daemon
   has dunst && run nice -n 15 dunst

   ### Remap Mousebuttons
   has imwheel && imwheel

   ### Renice some daemons
   pidof systemd-timesyncd && timeout 5 sudo renice -n 19 -p $(pidof systemd-timesyncd)
   pidof haveged && timeout 5 sudo renice -n 19 -p $(pidof haveged)

} &

exec $WindowManager

