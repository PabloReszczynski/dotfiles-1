#+defines
#-defines

PP_MODULES = -m foreach.pm

build::

post_install::
	which xrdb && xrdb -merge ~/.Xresources

include ../makefiles/std.mk
