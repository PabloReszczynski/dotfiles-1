LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
SHELL = zsh

build::

post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/zshrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/zshrc"

PP_FILES = zshrc

include ../../package.mk
