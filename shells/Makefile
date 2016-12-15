SHELLS = bash zsh

build: $(addsuffix .build, $(SHELLS))

install: $(addsuffix .install, $(SHELLS))

diff: $(addsuffix .diff, $(SHELLS))

clean: $(addsuffix .clean, $(SHELLS))

%.build:
	cd $* && make build

%.install:
	cd $* && make install

%.diff:
	cd $* && make diff

%.clean:
	cd $* && make clean
