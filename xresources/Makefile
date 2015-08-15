#+defines
COLOR_THEME = tango
#-defines

PP_MODULES = -m foreach.pm
PP_INCLUDE = themes
IGNORE_FILES = themes/%

build::

post_install::
	which xrdb && xrdb ~/.Xresources

include ../makefiles/std.mk
