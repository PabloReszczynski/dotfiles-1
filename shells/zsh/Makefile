LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
PROMPT_STYLE = MOSTLY_RIGHT
USE_FORTUNE = 0
TMUX_VERSION = $(shell tmux -V | sed 's/tmux //')

COLORIZE_COPE = 1
COLORIZE_GRC = 1
COLORIZE_CW = 1

SHELL = zsh

.vt_palette:
	if which conpalette; then \
		conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	else \
		cd "$(_TEMP_DIR)" && \
		git clone "https://github.com/braph/conpalette" && \
		./conpalette/bin/conpalette --shell --oneline blah-light > "$(_TEMP_DIR)/vt_palette"; \
	fi

.pre_build:: .vt_palette
	./tools/zsh_trim_setopts.sh zshoptions "$(_PACKAGE_BUILD_DIR)/zshoptions"
	#./tools/zsh_trim_aliases.sh zsh

.post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' "$(_PACKAGE_BUILD_DIR)/zshrc"
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' "$(_PACKAGE_BUILD_DIR)/zshrc"
	
PP_FILES = zshrc
FILEPP_INCLUDE = . .. $(_TEMP_DIR)

include ../../dotfile.mk
