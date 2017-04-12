SHELLS = bash zsh

build: $(addsuffix .build, $(SHELLS))

check_dependencies: $(addsuffix .check_dependencies, $(SHELLS))

install: $(addsuffix .install, $(SHELLS))

diff: $(addsuffix .diff, $(SHELLS))

clean: $(addsuffix .clean, $(SHELLS))

%.build:
	cd $* && make build

%.check_dependencies:
	cd $* && make check_dependencies

%.install:
	cd $* && make install

%.diff:
	cd $* && make diff

%.clean:
	cd $* && make clean
