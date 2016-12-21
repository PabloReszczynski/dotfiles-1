SHELLS = bash zsh

check_dependencies: $(addsuffix .check_dependencies, $(SHELLS))

build: $(addsuffix .build, $(SHELLS))

install: $(addsuffix .install, $(SHELLS))

diff: $(addsuffix .diff, $(SHELLS))

clean: $(addsuffix .clean, $(SHELLS))

%.check_dependencies:
	cd $* && make check_dependencies

%.build:
	cd $* && make build

%.install:
	cd $* && make install

%.diff:
	cd $* && make diff

%.clean:
	cd $* && make clean
