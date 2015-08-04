#!/bin/bash

SOUNDFILE="/usr/share/sounds/freedesktop/stereo/message.oga"
PLAYER="mpv"

if [ -e "$4" ] ; then
   #MSG=`cat "$4"`
   MSG=`head -1 "$4"`
   rm -f "$4"
fi

if [ "$1" == "MSG" ] ; then
   if [ "$2" == "IN" -o "$2" == "MUC" ] ; then
      notify-send -i mail-unread "$3" "$MSG" &
      $PLAYER "$SOUNDFILE" &
   fi
elif [ "$1" == "STATUS" ] ; then
   exit

   STATUS="$2"
   JID="$3"

   case "$2" in
      "_") STATUS="Offline";;
      "A") STATUS="Away";;
      "D") STATUS="DND";;
      "F") STATUS="Free";;
      "O") STATUS="Online";;
      "N") STATUS="Not available";;
   esac

   notify-send "[$STATUS] $JID" &
fi
