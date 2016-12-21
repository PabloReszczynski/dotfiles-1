# ................
# Dotfile Makefile
# ================

#! Variables that should not be used outside this Makefile should be
#! prefixed with an underscore. (Underscored variables don't show up
#! in shell completion)
#!
#! This Makefile uses an own special commenting syntax for generating
#! it's documentation.
#!
#!   #$: Variable starts (replaced with =item)
#!   #(: Group starts (replaced with =head1, =over, =back)
#!   #>: Plain text for documentation

# Parameters for building an dotfile package
# ==========================================

# Output destination for 'install'
ROOT_DIR ?= $(HOME)

# Output destination for 'build'
BUILD_DIR ?= /tmp/mk_dotfiles

# Directory to retrieve private information from inside preprocessor-files
PRIVATE_DIR ?= 

# Prefix directory, use this to place files in a ~/.subdirectory/
ifndef PREFIX_DIR
FILE_PREFIX := .
else
FILE_PREFIX :=
endif

# Filepp defaults
# ===============
FILEPP 			?= filepp
FILEPP_PREFIX 	?= \#>
FILEPP_MODULES ?=
FILEPP_INCLUDE ?=
FILEPP_FLAGS	?=

# Special defines
ifndef HOST
HOST := $(shell hostname)
else
ifeq ($(HOST), auto)
HOST := $(shell hostname)
endif
endif

# Ignore these files when auto generating file list
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

# Parameters end here, new variables below this line should be
# prefixed with an underscore.
# ============================================================

# Additional variables that should be passed to preprocessor
_ADDITIONAL_DEFINES = HOST PRIVATE_DIR _PACKAGE_NAME _PACKAGE_PATH _PACKAGE_BUILD_DIR _TEMP_DIR

_PACKAGE_PATH := $(realpath .)
_PACKAGE_NAME := $(notdir $(_PACKAGE_PATH))
_PACKAGE_BUILD_DIR = $(BUILD_DIR)/$(_PACKAGE_NAME)

# A directory that can be used for temp files in the build process
_TEMP_DIR = $(BUILD_DIR)/$(_PACKAGE_NAME)-temp

# Collect the defines in Makefile, create a list of -Ddefines
_DEFINED_VARS := $(shell sed -nr 's/^([a-zA-Z0-9_]+)[[:space:]]*:?=.*/\1/p' 'Makefile')
_DEFINED_VARS := $(sort $(_DEFINED_VARS))
_DEFINED_VARS += $(_ADDITIONAL_DEFINES)

_FILEPP_DEFINES := $(foreach V, $(_DEFINED_VARS), "-D$V=$($V)")
_FILEPP_MODULES := $(addprefix -m , $(FILEPP_MODULES))

# Important: _PACKAGE_BUILD_DIR precedes other include dirs
_FILEPP_INCLUDE := -I$(_PACKAGE_BUILD_DIR)
_FILEPP_INCLUDE += $(addprefix -I, $(FILEPP_INCLUDE))


# We export these variables for calling shell scripts
# ===================================================
export ROOT_DIR BUILD_DIR PRIVATE_DIR PREFIX_DIR FILE_PREFIX
export _PACKAGE_NAME _PACKAGE_PATH _PACKAGE_BUILD_DIR

export FILEPP FILEPP_PREFIX FILEPP_INCLUDE FILEPP_MODULES FILEPP_FLAGS
export _FILEPP_MODULES _FILEPP_INCLUDE _FILEPP_DEFINES

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

# This target must not be overriden, but it should preceed each makefile that
# overrides other targets (pre_build, post_build).
build:: check_dependencies clean $(_PACKAGE_BUILD_DIR) $(_TEMP_DIR) pre_build $(_DIRECTORIES) $(_FILES) $(_PP_FILES) post_build 

# These targets can be overriden
pre_build:: 	.force
post_build:: 	.force
pre_install:: 	.force
post_install:: .force

# Create the build directory for package
$(_PACKAGE_BUILD_DIR):
	mkdir -p "$@"

# Create the temp directory
$(_TEMP_DIR): # $(_PACKAGE_BUILD_DIR)
	mkdir -p "$@"
	# [[ -d "$(_PACKAGE_BUILD_DIR)/.temp" ]] && ln -s "$@" "$(_PACKAGE_BUILD_DIR)/.temp"

# Create directories
$(_DIRECTORIES): .force
	mkdir -p "$(_PACKAGE_BUILD_DIR)/$@"

# Copy files
$(_FILES): .force
	cp "$@" "$(_PACKAGE_BUILD_DIR)/$@"

# Generate files 
$(_PP_FILES): .force
	$(FILEPP) $(_FILEPP_DEFINES) $(_FILEPP_MODULES) $(_FILEPP_INCLUDE) -kc "$(FILEPP_PREFIX)" $(FILEPP_FLAGS) "$@" -o "$(_PACKAGE_BUILD_DIR)/$(subst .pp,,$@)"

# Check if all dependencies are installed
check_dependencies::
	@ echo -n "Checking for filepp ... "
	@ which filepp
	@ echo -n "Checking for filepp module 'testfile' ... "
	@ filepp -m testfile.pm /dev/null

# Finally copy files from build-dir to root-dir
.ONESHELL:
install:: pre_install
	cd "$(_PACKAGE_BUILD_DIR)"
	mkdir -p "$(ROOT_DIR)/$(PREFIX_DIR)"
	find . -mindepth 1 -type d | sed 's|^./||g' | while read -r D; do
		mkdir -p "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$D";
	done
	
	find . -mindepth 1 -type f -not -name .diff | sed 's|^./||g' | while read -r F; do
		cp "$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F";
	done
	
	cd "$(_PACKAGE_PATH)"
	$(MAKE) post_install

# Create a list of files that differ, used by diff and update
.SILENT:
.ONESHELL:
$(_PACKAGE_BUILD_DIR)/.diff:
	cd "$(_PACKAGE_BUILD_DIR)";
	find . -mindepth 1 -type f -not -name .diff | sed 's|^./||g' | while read -r FILE; do
		cmp --quiet "$$FILE" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$FILE" || echo "$$FILE";
	done > "$(_PACKAGE_BUILD_DIR)/.diff"

# Force to regenerate .diff-file 
rediff: clean-diff $(_PACKAGE_BUILD_DIR)/.diff

# Call 'diff' on files that would be modified
_DIFF_PROGRAM = diff
.ONESHELL:
diff: $(_PACKAGE_BUILD_DIR)/.diff
	exec 3<"$(_PACKAGE_BUILD_DIR)/.diff"
	while read -u 3 -r F; do
		$(_DIFF_PROGRAM) -- "$(_PACKAGE_BUILD_DIR)/$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F";
	done
	exec 3<&-

vimdiff:
	$(MAKE) _DIFF_PROGRAM=vimdiff diff

# Update only new files
.ONESHELL:
update: $(_PACKAGE_BUILD_DIR)/.diff
	while read -r F; do
		cp -v -- "$(_PACKAGE_BUILD_DIR)/$$F" "$(ROOT_DIR)/$(PREFIX_DIR)/$(FILE_PREFIX)$$F";
	done < "$(_PACKAGE_BUILD_DIR)/.diff"


help:
	@cat << EOF
	Usage: make clean|build|install|update|diff|rediff|template
	EOF

template:
	@cat << EOF
	#PREFIX_DIR = .prg
	#FILES = 
	#PP_FILES =
	#DIRECTORIES =
	
	include ../makefiles/std.mk
	EOF

clean: clean-temp
	rm -rf "$(_PACKAGE_BUILD_DIR)"

clean-diff:
	rm -f "$(_PACKAGE_BUILD_DIR)/.diff"

clean-build-dir:
	rmdir "$(BUILD_DIR)"

clean-temp:
	rm -rf "$(_TEMP_DIR)"

.force: # we use this to force building a target
