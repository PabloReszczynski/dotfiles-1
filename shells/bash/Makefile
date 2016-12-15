LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
SHELL = bash

build::

.ONESHELL:
vt_palette:
	cd "$(_TEMP_DIR)"
	git clone "https://github.com/braph/conpalette"
	./conpalette/bin/conpalette --shell blah-light > "$(_TEMP_DIR)/vt_palette"

pre_build:: vt_palette

post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
	@echo "Inserting color palette"
	cat "$(_PACKAGE_BUILD_DIR)/bashrc" >> "$(_TEMP_DIR)/vt_palette"
	mv "$(_TEMP_DIR)/vt_palette" "$(_PACKAGE_BUILD_DIR)/bashrc"

PP_FILES = bashrc
FILEPP_INCLUDE = . ..

include ../../package.mk
