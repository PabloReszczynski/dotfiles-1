EVILVTE_BUILD_DIR = /tmp/evilvte_build
_PACKAGE_PATH = $(realpath .)

check_dependencies:
	@ echo -n "Checking for git ... "
	@ which git
	@ echo -n "Checking for sudo ... "
	@ which sudo

.ONESHELL:
build:
	mkdir "$(EVILVTE_BUILD_DIR)"
	cd "$(EVILVTE_BUILD_DIR)"
	
	# Checkout and copy config.h to src dir
	git clone https://github.com/caleb-/evilvte
	cp "$(_PACKAGE_PATH)/config.h" evilvte/src/config.h
	
	# Enter src dir an build evilvte
	cd evilvte
	./configure
	make

.ONESHELL:
install:
	cd "$(EVILVTE_BUILD_DIR)"
	cd "evilvte"
	sudo make install

clean:
	rm -rf "$(EVILVTE_BUILD_DIR)"
	
