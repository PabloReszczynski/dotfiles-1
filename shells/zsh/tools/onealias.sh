#!/bin/bash

unset CDPATH
set -u
set +o histexpand

ALIASES=$(grep '^alias ' "$1")
sed -i '/^alias /d' "$1"

{
   printf "alias --"

   while read -r _ ALIAS; do
      printf " %s" "$ALIAS"
   done <<< "$ALIASES"

} >> "$1"
