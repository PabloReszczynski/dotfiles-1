SLOW_SYSTEM = 0

build::

.ONESHELL:
post_build::
	cd "$(_PACKAGE_BUILD_DIR)/vim/bundle" || exit 1
	git clone https://github.com/VundleVim/Vundle.vim

post_install::
	vim +PluginInstall

FILEPP_PREFIX = \">
DIRECTORIES = vim/view vim/bundle

include ../package.mk
