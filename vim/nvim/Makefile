SLOW_SYSTEM = 0
BASE_DIR = ~/.config/nvim

.pre_build::
	cp -rp ../_shared/* "$(_PACKAGE_BUILD_DIR)"

.ONESHELL:
.post_build::
	cd "$(_PACKAGE_BUILD_DIR)/bundle" || exit 1
	git clone https://github.com/VundleVim/Vundle.vim

.post_install::
	nvim +PluginInstall +quitall

PREFIX_DIR = .config/nvim
FILEPP_PREFIX = \">
PP_FILES = init.vim.pp
DIRECTORIES = view bundle

include ../../package.mk
