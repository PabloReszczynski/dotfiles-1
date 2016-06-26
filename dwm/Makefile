build::

.ONESHELL:
install::
	cd "$(_TEMP_DIR)/dwm"
	sudo make install

.ONESHELL:
pre_build::
	cd "$(_TEMP_DIR)"
	git clone "https://github.com/sr/dwm"
	cd dwm
	cp "$(_PACKAGE_PATH)/config.h" .
	make
	

IGNORE_FILES = %

include ../package.mk
