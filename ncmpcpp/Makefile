#+defines
COLOR = blue
#-defines

ODIR_SUBDIR = .ncmpcpp
NO_DOT_PREFIX = 1

IGNORE_FILES = makeDummyBindings.sh

build::

post_build::
	./makeDummyBindings.sh >> out/.ncmpcpp/bindings

include ../makefiles/std.mk
