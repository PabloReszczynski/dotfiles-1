THEME_COLOR = blue
MUSIC_DIR = /media/main/music

PREFIX_DIR = .config/ncmpcpp
IGNORE_FILES = makeDummyBindings.sh

.post_build::
	./makeDummyBindings.sh >> "$(_PACKAGE_BUILD_DIR)/bindings"

include ../package.mk
