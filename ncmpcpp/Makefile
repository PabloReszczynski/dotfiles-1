THEME_COLOR = blue
MUSIC_DIR = /media/main/music
NCMPCPP_VERSION = $(shell ncmpcpp --version | sed -n 's/ncmpcpp //p;q')

PREFIX_DIR = .config/ncmpcpp
IGNORE_FILES = makeDummyBindings.sh
FILEPP_MODULES = hash-comment.pm remove-empty-lines.pm

.post_build::
	./makeDummyBindings.sh >> "$(_PACKAGE_BUILD_DIR)/bindings"

include ../dotfile.mk
