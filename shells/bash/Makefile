LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
SHELL = bash

build::

post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/bashrc"

PP_FILES = bashrc

include ../../package.mk
