#+defines
LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
#-defines

build::

post_build:: 
	@echo "Removing comments"
	sed -i '/^#/d' out/.zshrc
	
	@echo "Removing empty lines"
	sed -i '/^$$/d' out/.zshrc

INSTALL_PP_FILES = zshrc

include ../makefiles/std.mk
