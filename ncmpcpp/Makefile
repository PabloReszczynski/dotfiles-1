THEME_COLOR = blue

PREFIX_DIR = .ncmpcpp
IGNORE_FILES = makeDummyBindings.sh

build::
post_build::
	./makeDummyBindings.sh >> "$(_PACKAGE_BUILD_DIR)/bindings"

include ../package.mk
