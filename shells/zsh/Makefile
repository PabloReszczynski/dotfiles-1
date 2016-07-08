LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
SHELL = zsh

build::

.ONESHELL:
vt_palette:
	cd "$(_TEMP_DIR)"
	git clone "https://github.com/braph/conpalette"
	./conpalette/bin/conpalette --shell --oneline blah-light > "$(_PACKAGE_BUILD_DIR)/vt_palette"


pre_build:: vt_palette
	./tools/zsh_trim_setopts.sh zshoptions "$(_PACKAGE_BUILD_DIR)/zshoptions"
	#./tools/zsh_trim_aliases.sh zsh
	

post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/zshrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/zshrc"

PP_FILES = zshrc
FILEPP_INCLUDE = . ..

include ../../package.mk
