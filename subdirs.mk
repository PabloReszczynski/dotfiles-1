ifndef SUBDIRS
SUBDIRS = $(shell echo *)
endif

build:                  $(addsuffix .build,              $(SUBDIRS))
clean:                  $(addsuffix .clean,              $(SUBDIRS))
diff:                   $(addsuffix .diff,               $(SUBDIRS))
help:                   $(addsuffix .help,               $(SUBDIRS))
info:                   $(addsuffix .info,               $(SUBDIRS))
install:                $(addsuffix .install,            $(SUBDIRS))
check_dependencies:     $(addsuffix .check_dependencies, $(SUBDIRS))

%.build: 
	cd $* && $(MAKE) $(-*-command-variables-*-) build

%.clean:
	cd $* && $(MAKE) $(-*-command-variables-*-) check_dependencies

%.diff:
	cd $* && $(MAKE) $(-*-command-variables-*-) diff

%.help:
	cd $* && $(MAKE) $(-*-command-variables-*-) help

%.info:
	cd $* && $(MAKE) $(-*-command-variables-*-) info

%.install:
	cd $* && $(MAKE) $(-*-command-variables-*-) install

%.check_dependencies:
	cd $* && $(MAKE) $(-*-command-variables-*-) check_dependencies

