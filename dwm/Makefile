DWM_URL = http://dwm.suckless.org/patches
DWM_PATCHES = dwm-6.0-stacker.diff

build::

install::
	cd "$(_TEMP_DIR)/dwm" && sudo make install

dwm-src:
	cd "$(_TEMP_DIR)" && git clone "http://git.suckless.org/dwm"

config.h:
	cp "$(_PACKAGE_PATH)/config.h" "$(_TEMP_DIR)/dwm/"

$(DWM_PATCHES):
	cd "$(_TEMP_DIR)/dwm" && wget "$(DWM_URL)/$@" && patch -p1 < "$@"

pre_build:: dwm-src config.h $(DWM_PATCHES)
	cd "$(_TEMP_DIR)/dwm" && make
	

IGNORE_FILES = %

include ../package.mk
