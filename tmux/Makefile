THEME_COLOR = blue

FILEPP_MODULES = bigdef.pm function.pm hash-comment.pm remove-empty-lines.pm

.post_install::
	@echo -n "Reloading tmux conf ... "
	-tmux source ~/.tmux.conf && echo DONE || echo FAILED

include ../dotfile.mk
