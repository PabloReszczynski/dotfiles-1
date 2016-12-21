# #!/bin/bash
# 
# for i in */; do
#    echo "$i";
#    cd "$i";
#    make && echo "$i" && make diff;
#    cd ..;
#    read;
# done
# exit
# 
# OWD=$PWD
# 
# for dot; do
# 	if ! [[ -e "$dot" ]]; then
# 		echo "$0: $dot: not found"
# 		exit 1
# 	fi
# done
# 
# for dot; do
# 	cd "$OWD"
# 
# 	if ! [[ -d "$dot" ]]; then
# 		continue
# 	fi
# 
# 	if ! cd "$dot"; then
# 		echo "$0: $dot: cd not possible"
# 		continue
# 	fi
# 
# 	make
# 	make install
# 	make clean
# done

FILES = $(notdir $(realpath $(wildcard */)))
LOG = /tmp/$(USER)-mk.log
VARIABLES ?= 

check_dependencies: $(addsuffix .check_dependencies, $(FILES))

build: $(addsuffix .build, $(FILES))

diff: $(addsuffix .diff, $(FILES))

install: $(addsuffix .install, $(FILES))

clean: clean-status $(addsuffix .clean, $(FILES))

clean-status:
	rm -f *.build 
	rm -f *.install

clean-log:
	rm -f $(LOG)

show-log:
	less $(LOG)

%.check_dependencies: clean-log
	@ echo -n "$* ... "
	@ ( cd $* && make check_dependencies ) >> $(LOG)
	@ echo "done"


%.build:
	( cd $* && make build $(VARIABLES) ) && touch $*.build || echo "Failed $*" >> $(LOG)

%.diff:
	( cd $* && make diff )

%.install:
	cd $* && make install
	touch $@

%.clean:
	cd $* && make clean
