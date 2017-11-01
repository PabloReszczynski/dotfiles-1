DWM_URL = http://dwm.suckless.org/patches
DWM_PATCHES = dwm-stacker-6.0.diff

build::

install::
	cd "$(_TEMP_DIR)/dwm" && sudo make install

dwm-src:
	cd "$(_TEMP_DIR)" && { [[ -d "dwm" ]] || git clone "http://git.suckless.org/dwm"; }

config.h:
	cp "$(_PACKAGE_PATH)/config.h" "$(_TEMP_DIR)/dwm/"

$(DWM_PATCHES):
	cd "$(_TEMP_DIR)/dwm" && wget "$(DWM_URL)/$@" && patch -p1 < "$@"

pre_build:: dwm-src config.h $(DWM_PATCHES)
	cd "$(_TEMP_DIR)/dwm" && make
	

IGNORE_FILES = %

include ../dotfile.mk
