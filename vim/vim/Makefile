SLOW_SYSTEM = 0
BASE_DIR = ~/.vim

.pre_build::
	cp -pr ../_shared "$(_PACKAGE_BUILD_DIR)/vim"

.ONESHELL:
.post_build::
	cd "$(_PACKAGE_BUILD_DIR)/vim/bundle" || exit 1
	git clone https://github.com/VundleVim/Vundle.vim

.post_install::
	vim +PluginInstall +quitall

FILEPP_PREFIX = \">
PP_FILES = vimrc.pp
DIRECTORIES = vim/view vim/bundle

include ../../package.mk
