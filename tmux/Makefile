THEME_COLOR = blue

PP_MODULES = bigdef.pm function.pm

build::
post_install::
	@echo -n "Reloading tmux conf ... "
	killall -u $(USER) tmux_daemon.pl || true
	@tmux source ~/.tmux.conf && echo 'DONE' || echo 'FAILED'

include ../package.mk
