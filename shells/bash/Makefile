LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
TMUX_VERSION = $(shell tmux -V | sed 's/tmux //')

COLORIZE_COPE = 1
COLORIZE_GRC = 1
COLORIZE_CW = 1

SHELL = bash

.vt_palette:
	if which conpalette; then \
		conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	else \
		cd "$(_TEMP_DIR)" && \
		git clone "https://github.com/braph/conpalette" && \
		./conpalette/bin/conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	fi

.pre_build:: .vt_palette

.post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/bashrc"
	
PP_FILES = bashrc
FILEPP_INCLUDE = . .. $(_TEMP_DIR)

include ../../dotfile.mk
