LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0

COLORIZE_COPE = 1
COLORIZE_GRC = 1
COLORIZE_CW = 1

SHELL = bash

.ONESHELL:
.vt_palette:
	cd "$(_TEMP_DIR)"
	git clone "https://github.com/braph/conpalette"
	./conpalette/bin/conpalette --oneline --shell blah-light > vt_palette

.pre_build:: .vt_palette

.post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
PP_FILES = bashrc
FILEPP_INCLUDE = . .. $(_TEMP_DIR)

include ../../dotfile.mk
