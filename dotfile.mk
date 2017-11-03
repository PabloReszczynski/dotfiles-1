# dotfile.mk - generate and install customizable dotfiles
# Copyright (C) 2017 Benjamin Abendroth
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# ================
# Dotfile Makefile
# ================

# Variables that should not be used outside this Makefile should be
# prefixed with an underscore. (Underscored variables don't show up
# in shell completion)
#
# Documentation that can be retrieved with 'make help-variables' must
# be prefixed with "#$".
#
# Documentation that can be retrieved with 'make help-commands' must
# be prefixed with "#!".

# Parameters for building an dotfile package
# ==========================================

#$ ROOT_DIR
#$  Output destination for 'make install'.
ROOT_DIR ?= $(HOME)

#$ BUILD_DIR
#$  Output destination for 'make build'.
BUILD_DIR ?= /tmp/dotfiles-$(USER)

#$ PRIVATE_DIR
#$  Directory to retrieve private information from inside preprocessor-files.
PRIVATE_DIR ?= 

#$ PREFIX_DIR
#$  Prefix directory, use this to place files in a ~/.subdirectory/
ifndef PREFIX_DIR
FILE_PREFIX := .
else
FILE_PREFIX :=
endif

# Filepp defaults
# ===============

#$ FILEPP
#$  Name of the 'filepp' binary
FILEPP 			?= filepp

#$ FILEPP_PREFIX
#$  Prefix for recognizing preprocessor directives. Option '-kc'
FILEPP_PREFIX 	?= \#>

#$ FILEPP_MODULES
#$  Modules to use in filepp
FILEPP_MODULES ?=

#$ FILEPP_INCLUDE
#$  Include directory for filepp
FILEPP_INCLUDE ?=

#$ FILEPP_FLAGS
#$  Custom filepp flags
FILEPP_FLAGS	?=

#$ IGNORE_FILES
#$  Ignore these files when auto generating file list
IGNORE_FILES ?=

# If neither FILES nor PP_FILES is given, auto generate file-list
ifndef FILES
ifndef PP_FILES
# files that should simply be copied
FILES := auto
# files for preprocessor
PP_FILES := auto
endif
endif

# Special defines
ifndef HOST
HOST := $(shell hostname)
else
ifeq ($(HOST), auto)
HOST := $(shell hostname)
endif
endif

ifndef OPERATING_SYSTEM
UNAME := $(shell uname -o)
endif

# Parameters end here, new variables below this line should be
# prefixed with an underscore.
# ============================================================

_PACKAGE_PATH := $(realpath .)
_PACKAGE_NAME := $(notdir $(_PACKAGE_PATH))
_PACKAGE_BUILD_DIR = $(BUILD_DIR)/$(_PACKAGE_NAME)

# A directory that can be used for temp files in the build process
_TEMP_DIR = $(BUILD_DIR)/$(_PACKAGE_NAME)-temp

# Collect the defines in Makefile, create a list of -Ddefines
# ===========================================================

# Additional variables that should be passed to preprocessor
_ADDITIONAL_DEFINES = HOST OPERATING_SYSTEM PRIVATE_DIR _TEMP_DIR \
							 _PACKAGE_NAME _PACKAGE_PATH _PACKAGE_BUILD_DIR

# Ignore these variables found in Makfile
_IGNORE_VARS := FILES PP_FILES IGNORE_FILES \
	ROOT_DIR BUILD_DIR PRIVATE_DIR PREFIX_DIR FILE_PREFIX \
	FILEPP FILEPP_PREFIX FILEPP_MODULES FILEPP_INCLUDE FILEPP_FLAGS
_CONFIG_VARS := $(shell sed -nr 's/^([a-zA-Z0-9][a-zA-Z0-9_]+)[[:space:]]*:?=.*/\1/p' 'Makefile')
_CONFIG_VARS := $(sort $(_CONFIG_VARS)) # deduplicate variables
_CONFIG_VARS := $(filter-out $(_IGNORE_VARS), $(_CONFIG_VARS))
_DEFINED_VARS := $(_CONFIG_VARS) $(_ADDITIONAL_DEFINES)

_FILEPP_DEFINES := $(foreach V, $(_DEFINED_VARS), "-D$V=$($V)")
_FILEPP_MODULES := $(addprefix -m , $(FILEPP_MODULES))

# Important: _PACKAGE_BUILD_DIR precedes other include dirs
_FILEPP_INCLUDE := -I$(_PACKAGE_BUILD_DIR)
_FILEPP_INCLUDE += $(addprefix -I, $(FILEPP_INCLUDE))


# We export these variables for calling shell scripts
# ===================================================
export ROOT_DIR BUILD_DIR PRIVATE_DIR PREFIX_DIR FILE_PREFIX
export FILEPP FILEPP_PREFIX FILEPP_INCLUDE FILEPP_MODULES FILEPP_FLAGS
export FILES PP_FILES DIRECTORIES IGNORE_FILES
export $(_DEFINED_VARS)


# File-selection logic starts here
# ================================

# We NEVER want these files (BUILD_DIR could also be inside package dir)
_FORCE_IGNORE := $(MAKEFILE_LIST) $(BUILD_DIR) $(BUILD_DIR)/%

ifeq ($(PP_FILES), auto)
_PP_FILES := $(shell find . -mindepth 1 -type f -name '*.pp')
else
_PP_FILES := $(PP_FILES)
endif

ifeq ($(FILES), auto)
_FILES := $(shell find . -mindepth 1 -type f -not -name '*.pp')
else
_FILES := $(FILES)
endif

# Repair paths
_FILES := $(subst $(_PACKAGE_PATH)/,, $(realpath $(_FILES)))
_PP_FILES := $(subst $(_PACKAGE_PATH)/,, $(realpath $(_PP_FILES)))

# Remove ignored files
_FILES := $(filter-out $(_FORCE_IGNORE) $(IGNORE_FILES), $(_FILES))
_PP_FILES := $(filter-out $(_FORCE_IGNORE) $(IGNORE_FILES), $(_PP_FILES))

# Get the list of directories
ifdef DIRECTORIES
_DIRECTORIES := $(DIRECTORIES)
else
_DIRECTORIES :=
endif
_DIRECTORIES += $(subst ./,, $(dir $(_FILES) $(_PP_FILES)))
_DIRECTORIES := $(sort $(_DIRECTORIES))


# Makefile rules start here
# =========================

.DEFAULT_GOAL := build

# This target must not be overriden, but it should preceed each makefile that
# overrides other targets (.pre_build, .post_build).
build:: .check_dependencies clean $(_PACKAGE_BUILD_DIR) $(_TEMP_DIR) \
			.pre_build .build_msg $(_DIRECTORIES) $(_FILES) $(_PP_FILES) .post_build 
.build_msg:
	@echo '> Starting build ...'

# These targets can be overriden
.pre_build:: .force .pre_build_msg
.pre_build_msg:
	@echo '> Entering pre_build hook ...'

.post_build:: .force .post_build_msg
.post_build_msg:
	@echo '> Entering post_build hook ...'

.pre_install:: .force .pre_install_msg
.pre_install_msg:
	@echo '> Entering pre_install hook ...'

.post_install:: .force .post_install_msg
.post_install_msg:
	@echo '> Entering post_install hook ...'

# Create the build directory for package
$(_PACKAGE_BUILD_DIR):
	mkdir -p "$@"

# Create the temp directory
$(_TEMP_DIR):
	mkdir -p "$@"

# Create directories
$(_DIRECTORIES): .force
	mkdir -p -v "$(_PACKAGE_BUILD_DIR)/$@"

# Copy files
$(_FILES): .force
	cp -v -p "$@" "$(_PACKAGE_BUILD_DIR)/$@"

# Generate files 
$(_PP_FILES): .force
	@echo ">> Preprocessing $@ ..."
	$(FILEPP) \
		$(_FILEPP_DEFINES) \
		$(_FILEPP_MODULES) \
		$(_FILEPP_INCLUDE) \
		-kc "$(FILEPP_PREFIX)" \
		$(FILEPP_FLAGS) "$@" -o "$(_PACKAGE_BUILD_DIR)/$(subst .pp,,$@)"

#! check_dependencies
#!  Check if all dependencies are installed
check_dependencies: .check_dependencies

.SILENT:
.check_dependencies::
	echo -n "Checking for filepp ... "
	which filepp
	#echo -n "Checking for filepp module 'testfile' ... "
	#filepp -m testfile.pm /dev/null && echo OK

#! install
#!  Copy files from build-dir to root-dir
install:: .pre_install
	mkdir -p "$(ROOT_DIR)/$(PREFIX_DIR)"
	
	cd "$(_PACKAGE_BUILD_DIR)" || { \
		echo "Did you run 'make build' yet?"; \
		exit 1; \
	}; \
	\
	find . -mindepth 1 -type d | sed 's|^./||g' | while read -r D; do \
		mkdir -p "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$D"; \
	done; \
	\
	find . -mindepth 1 -type f -not -name .diff | sed 's|^./||g' | while read -r F; do \
		cp -v -p "$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F"; \
	done;
	
	cd "$(_PACKAGE_PATH)"; \
	$(MAKE) .post_install

# Create a list of files that differ, used by diff and update
.SILENT:
$(_PACKAGE_BUILD_DIR)/.diff:
	cd "$(_PACKAGE_BUILD_DIR)" || { \
		echo "Did you run 'make build' yet?"; \
		exit 1; \
	}; \
	find . -mindepth 1 -type f -not -name .diff | sed 's|^./||g' | while read -r FILE; do \
		cmp --quiet "$$FILE" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$FILE" || echo "$$FILE"; \
	done > "$(_PACKAGE_BUILD_DIR)/.diff"

# Force to regenerate .diff-file 
rediff: clean-diff $(_PACKAGE_BUILD_DIR)/.diff

# Call 'diff' on files that would be modified
_DIFF_PROGRAM = diff

#! diff
#!  Show the difference between newly generated files in the build directory
#! and the old files in the root directory.
diff: .force $(_PACKAGE_BUILD_DIR)/.diff
	exec 9<"$(_PACKAGE_BUILD_DIR)/.diff"; \
	while read -u 9 -r F; do \
		$(_DIFF_PROGRAM) -- "$(_PACKAGE_BUILD_DIR)/$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F"; \
	done; \
	exec 9<&-

#! vimdiff
#!  Same as diff, but use 'vimdiff' as diff program.
vimdiff:
	$(MAKE) _DIFF_PROGRAM=vimdiff diff

#! info
#!  Show a list of configurable variables in Makefile
info:
	$(foreach VAR, $(_CONFIG_VARS), \
		$(info $(VAR) = $(value $(VAR)) ) \
	)

#! update
#!  Update only new files
update: $(_PACKAGE_BUILD_DIR)/.diff
	while read -r F; do \
		cp -p -v -- "$(_PACKAGE_BUILD_DIR)/$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F"; \
	done < "$(_PACKAGE_BUILD_DIR)/.diff"

#! help
#!  Show help summary
.SILENT:
help:
	cat << EOF
	Usage: make clean|build|info|install|update|diff|rediff|template
	
	Type 'make help-variables' or 'make help-commands'
	EOF

#! help-variables
#!  Show help for variables
help-variables:
	@grep -h '^#\$$' $(MAKEFILE_LIST) | sed -r -e 's/^#.//g' -e 's/^ ([^ ])/\n\1/g'

#! help-commands
#!  Show help for commands
help-commands:
	@grep -h '^#!' $(MAKEFILE_LIST) | sed -r -e 's/^#.//g' -e 's/^ ([^ ])/\n\1/g'

#! clean
#!  Remove the build dir
clean: clean-temp
	rm -rf "$(_PACKAGE_BUILD_DIR)"

clean-diff:
	rm -f "$(_PACKAGE_BUILD_DIR)/.diff"

clean-build-dir:
	rmdir "$(BUILD_DIR)"

clean-temp:
	rm -rf "$(_TEMP_DIR)"

.force: # we use this to force building a target
