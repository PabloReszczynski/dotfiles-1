#!/usr/bin/env bash

example='/usr/share/doc/ncmpcpp/bindings'

sed -n "s/#def_key/def_key/p" "$example" | sort -u | sed 's/$/\n\tdummy/g'
