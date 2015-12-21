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

has_run() {
   has "$1" && run "$@"
}

{
   ### make some temporary directories
   {
      mkdir -p "/tmp/$USER."{adobe,macromedia}
      mkdir -p "/tmp/$USER.mozilla."{develop2,norm}
      mkdir -p "/tmp/$USER.downloads"
      mkdir -p "/tmp/$USER.cache"
   } &

   #--- initialize X11-stuff ---------------------------
   #
   # compose using Capslock
   setxkbmap -option compose:caps
   #
   [[ -e ~/.Xresources ]]  && xrdb -merge ~/.Xresources
   [[ -e ~/.Xmodmap ]]     && xmodmap ~/.Xmodmap
   [[ -e ~/.xbindkeysrc ]] && xbindkeys
   #----------------------------------------------------

   ### Set background to something like black
   # (hack for fucking flash player)
   xsetroot -solid '#000001'

   ### Set background image if available
   has_run nitrogen --restore

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

   ### Open browser
   has_run dillo;

   ### Set up our screensaver
   has xscreensaver && run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))
   #xscreensaver-command -lock

   ### Adjust key repeat time/delay
   xset r rate 260 50

   ### Finally run some applications
#> if "HOST" eq "pizwo"
   has_run mpd
   has_run synergys
#> elif "HOST" eq "samsung"
   has_run synergyc 10.0.0.10
#> endif

   # == Our notification daemon ===
   has_run dunst;

   # === Remap Mousebuttons ===
   #has_run imwheel

} &

exec $WindowManager

