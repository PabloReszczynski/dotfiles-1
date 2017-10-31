THEME_COLOR = blue

FILEPP_MODULES = bigdef.pm function.pm

.post_install::
	@echo -n "Reloading tmux conf ... "
	-tmux source ~/.tmux.conf && echo 'DONE' || echo 'FAILED'

include ../package.mk
