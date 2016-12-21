#!/bin/SHELL_NAME

#> define LogFile "/dev/null"
#> define LogFile "/tmp/xinitrc.$USER.$$.WINDOW_MANAGER.log"

run() {
   "$@" &
}

has() {
   which "$1"
}

has_run() {
   has "$1" && run "$@"
}

{
   date; # date for for log file
   sleep 3; # race conditions???

   # === initialize X11 stuff =============================

   # load Xresources
   [ -e ~/.Xresources ]  && has_run xrdb ~/.Xresources
   
   # Set background to 'nearly black' (hack for fucking flash player)
   has_run xsetroot -solid '#000001'
 
   # Repeat those commands, in case the keyboard/mouse gets unplugged
   while :; do
     # Adjust keyboard repeat time/delay
     xset r rate 255 60

     # Adjust mouse acceleration
     xset m 4 4

     # Use capslock as compose key
     setxkbmap -option compose:caps

     sleep 60
   done &

   # Modify keyboard layout
   [ -e ~/.Xmodmap ]     && has_run xmodmap ~/.Xmodmap
  
   # Load additional keybindings
   [ -e ~/.xbindkeysrc ] && has_run xbindkeys

   # Set background image if available
   has_run nitrogen --restore

   # Set up our screensaver
   has_run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))
   #xscreensaver-command -lock
   # ======================================================


   # === dirs that we want to keep in /tmp ================
   USER_TMP_DIR="/tmp/home-temp-${USER}";

   #TODO? mozilla stuff?
   for d in \
      .adobe \
      .macromedia \
      .cache \
      ; \
   do
      echo "Linking $d to temp";
      rm ~/"$d" || rmdir ~/"$d"
      mkdir -p "$USER_TMP_DIR/$d" && \
      ln -s "$USER_TMP_DIR/$d" ~/"$d";
   done
   # ======================================================


   # === Select terminal emulator =========================
      # TODO: tmux has-session -t main, tmux-new-session -d background
   if has uxterm; then
      terminal_cmd='uxterm -fullscreen -e'
   elif has xterm; then
      terminal_cmd='xterm -fullscreen -e'
   elif has evilvte; then
      terminal_cmd='evilvte -f -e'
   elif has terminator; then
      terminal_cmd='terminator -f -b -x'
   fi

   # === Select terminal init =============================
   if has tmux; then
      if ! tmux has-session; then
         terminal_init='tmux -2'
      else
         terminal_init='tmux -2 attach'
         #run tmux new-session -d -s 0
         #has mcabber && tmux new-window -d mcabber
         #has ncmpcpp && tmux new-window -d ncmpcpp
      fi
   elif has zsh; then
      terminal_init='zsh';
   else
      terminal_init='bash';
   fi

   # === Start terminal emulator ==========================
   run $terminal_cmd $terminal_init;

   # === Open browser =====================================
   has_run dillo blog.fefe.de;
   
   has_run inox;

   # === Host based applications ==========================
#> if "HOST" eq "pizwo"
   #has_run synergys
#> elif "HOST" eq "samsung"
   #has_run synergyc 10.0.0.10
#> endif
#
   # === Music Player Daemon ==============================
   has_run mpd;

   # === Our notification daemon ===
   has_run dunst;

   # === Remap Mousebuttons ===
   has_run imwheel;

} >"$LogFile" 2>&1 &

exec WINDOW_MANAGER

# vim: set syntax=sh:
