#!/bin/SHELL_NAME

#> define LOG_FILE "/dev/null"
#> define LOG_FILE "/tmp/xinitrc.$USER.$$.WINDOW_MANAGER.log"

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

   # === Dirs that we want to keep in /tmp ================
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
      chmod 0755 "$USER_TMP_DIR/$d" && \
      ln -s "$USER_TMP_DIR/$d" ~/"$d";
   done
   # ======================================================

   # === Music Player Daemon ==============================
   has_run mpd;

   # === Our notification daemon ===
   #has_run dunst;

   # === Remap Mousebuttons ===
   #has_run imwheel;

   # === Open browser =====================================
   has_run dillo blog.fefe.de;
   has_run inox;

   # === Host based applications ==========================
#> if "HOST" eq "pizwo"
   #has_run synergys
#> elif "HOST" eq "samsung"
   #has_run synergyc 10.0.0.10
#> endif

   # === Select terminal emulator =========================
   if has uxterm; then
      terminal_cmd='uxterm -maximized -e'
   elif has xterm; then
      terminal_cmd='xterm -maximized -e'
   elif has evilvte; then
      terminal_cmd='evilvte -f -e'
   elif has terminator; then
      terminal_cmd='terminator -f -b -x'
   fi
   # ======================================================

   # === Select terminal init =============================
   if has tmux; then
      tmux has-session -t 'main' || tmux new-session -d -s 'main'
      tmux has-session -t 'bg'   || tmux new-session -d -s 'bg'

      has ncmpcpp && tmux new-window -t 'main:' ncmpcpp
      if has finch; then
         tmux new-window -t 'main:' finch
      elif has mcabber; then
         tmux new-window -t 'main:' mcabber
      fi

      terminal_init='tmux -2 attach -t main'
   elif has zsh; then
      terminal_init='zsh';
   else
      terminal_init='bash';
   fi
   # ======================================================

   # === Wait for window manager ==========================
   sleep 3;
   # ======================================================

   # === initialize X11 stuff =============================

   # load Xresources
   [ -e ~/.Xresources ]  && has_run xrdb ~/.Xresources
   
   # Set background to 'nearly black' (hack for fucking flash player)
   has_run xsetroot -solid '#000001'
 
   # Modify keyboard layout
   [ -e ~/.Xmodmap ]     && has_run xmodmap ~/.Xmodmap
  
   # Load additional keybindings
   [ -e ~/.xbindkeysrc ] && has_run xbindkeys

   # xset/setxkbmap
   has_run xset_daemon

   # Set background image if available
   has_run nitrogen --restore

   # Set up our screensaver
   has_run xscreensaver -no-splash
   #xset dpms 0 0 $(( 60 * 10 ))
   #xscreensaver-command -lock
   # ======================================================

   sleep 1;

   # === Start terminal emulator ==========================
   run $terminal_cmd $terminal_init;

} >LOG_FILE 2>&1 &

exec WINDOW_MANAGER

# vim: set syntax=sh:
