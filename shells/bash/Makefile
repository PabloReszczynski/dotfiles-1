SHELL_NAME = bash

LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0

include ../common.mk

COLORIZE_COPE = 1
COLORIZE_GRC = 1
COLORIZE_CW = 1

.vt_palette:
	if which conpalette; then \
		conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	else \
		cd "$(_TEMP_DIR)" && \
		git clone "https://github.com/braph/conpalette" && \
		./conpalette/bin/conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	fi

.pre_build:: .vt_palette

PP_FILES = bashrc
FILEPP_MODULES = hash-comment.pm remove-empty-lines.pm
FILEPP_INCLUDE = . .. $(_TEMP_DIR)

include ../../dotfile.mk
