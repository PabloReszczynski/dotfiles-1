#!/bin/bash

OWD=$PWD

for dot; do
	if ! [[ -e "$dot" ]]; then
		echo "$0: $dot: not found"
		exit 1
	fi
done

for dot; do
	cd "$OWD"

	if ! [[ -d "$dot" ]]; then
		continue
	fi

	if ! cd "$dot"; then
		echo "$0: $dot: cd not possible"
		continue
	fi

	make
	make install
	make clean
done

