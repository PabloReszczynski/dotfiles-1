COLOR_THEME = tango
FONTSIZE = 13

FILEPP_MODULES = foreach.pm
FILEPP_INCLUDE = themes
IGNORE_FILES = themes/%

.post_install::
	which xrdb && xrdb ~/.Xresources

include ../dotfile.mk
