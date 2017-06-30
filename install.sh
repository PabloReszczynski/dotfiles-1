#!/bin/bash

unset CDPATH
set -u +o histexpand

LOG_DIR="/tmp/dotfiles-$USER.logs"
VARIABLES=''
CURRENT_DIR=$(pwd)
declare -a FILES=()
declare -a FAILED=()

mkdir -p "$LOG_DIR" || {
   echo "Could not create log dir" >&2
   exit 1;
}

for arg; do
   if [[ "$arg" != "${arg/=/}" ]]; then
      VARIABLES+=" $arg"
   elif [[ -d "$arg" ]]; then
      FILES+=($arg)
   else
      echo "> skipping $arg (not a directory)"
   fi
done

for file in "${FILES[@]}"; do
   cd "$CURRENT_DIR"

   if ! cd "$file"; then
      echo "Directory not found" > "$LOG_DIR/$file"
      FAILED+=($file)
      continue
   fi

   echo "> building $file"
   if ! make build $VARIABLES &> "$LOG_DIR/$file"; then
      FAILED+=($file)
      continue
   fi

   #echo "> installing $file"
   #if ! make install $VARIABLES &> "$LOG_DIR/$file"; then
   #   FAILED+=($file)
   #   continue
   #fi
done

printf "> Done\n\n"

if [[ -n "${FAILED[@]}" ]]; then
   echo "> These dotfiles failed to build: ${FAILED[@]}"
   echo "> See logs in $LOG_DIR"
fi
