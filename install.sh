#!/bin/bash

unset CDPATH
set -u +o histexpand

LOG_DIR="/tmp/dotfiles-$USER.logs"
VARIABLES=''
CURRENT_DIR=$(pwd)
declare -a FILES=()
declare -a FAILED=()

rm -rf "$LOG_DIR"
mkdir -p "$LOG_DIR" || {
   echo "Could not create log dir" >&2
   exit 1;
}

ACTION=$1; shift
if [[ "$ACTION" != "diff" ]] && \
   [[ "$ACTION" != "build" ]] && \
   [[ "$ACTION" != "install" ]]; then
   echo "Wrong first argument"
fi

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

   echo "> ${ACTION}ing $file"
   if ! make $ACTION $VARIABLES &> "$LOG_DIR/$file"; then
      FAILED+=($file)
      continue
   fi
done

printf "> Done\n\n"

if [[ -n "${FAILED[@]}" ]]; then
   if [[ "$ACTION" == 'diff' ]]; then
      echo "> These dotfiles are different: ${FAILED[@]}"
      echo "> See logs in $LOG_DIR"
   else
      echo "> These dotfiles failed to $ACTION: ${FAILED[@]}"
      echo "> See logs in $LOG_DIR"
   fi
fi
