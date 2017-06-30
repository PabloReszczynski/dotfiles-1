COLOR_THEME = tango

FILEPP_MODULES = foreach.pm
FILEPP_INCLUDE = themes
IGNORE_FILES = themes/%

build::

post_install::
	which xrdb && xrdb ~/.Xresources

include ../package.mk
