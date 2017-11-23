THEME_COLOR = blue
DEFAULT_SHELL = $(shell which zsh 2>/dev/null || which bash 2>/dev/null)
HAVE_DEV_SHM = $(shell test -d /dev/shm && echo 1 || echo 0)

FILEPP_MODULES = bigdef.pm function.pm hash-comment.pm remove-empty-lines.pm

.post_install::
	@echo -n "Reloading tmux conf ... "
	-tmux source ~/.tmux.conf && echo DONE || echo FAILED

include ../dotfile.mk
