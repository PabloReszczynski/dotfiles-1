#!/bin/bash

MCABBER_BUFFER=/tmp/mcabber_bind

# dump "bind" command to file
mcabber -f <(printf "bind\n\n") > "$MCABBER_BUFFER" &
sleep 1;
kill %1

sed -n -r "s/.*Key[[:space:]]*(.*) is bound to: ([a-zA-Z0-9_ -]*).*/bind \1 \2/p" "$MCABBER_BUFFER"

rm "$MCABBER_BUFFER"
