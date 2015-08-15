# PWD, we use this for subst()
PWD := $(realpath .)

# output destination for 'install'
DEST ?= $(HOME)

# output destination for 'build'
ODIR ?= out

# use this variable to place files in an .config/xzy subdirectory
ODIR_SUBDIR ?=

# this can be used to add a dot to the result files
ifdef NO_DOT_PREFIX
RESULT_FILE_PREFIX =
else
RESULT_FILE_PREFIX = .
endif

###
# filepp defaults
###
PP ?= filepp
PP_KC ?= \#>
PP_MODULES ?=

###
# collect the DEFINES in Makefile, create a list of -Ddefines
###
define setup_defines
$(eval DEFINES := $(shell awk -F= '/#-defines/ {exit} /#\+defines/ {getline; p=1} p {print $$1}' $(MAKEFILE_LIST)))
$(eval PP_DEFINES := $(foreach D, $(DEFINES), -D$D="$($D)"))
endef

###
# file-selection logic starts here
###

# we NEVER want these files
FORCE_IGNORE := $(MAKEFILE_LIST) $(ODIR) $(ODIR)/%

# auto generate file list
# if neither INSTALL_FILES nor INSTALL_PP_FILES given
ifndef INSTALL_FILES
ifndef INSTALL_PP_FILES
$(info Setting INSTALL_FILES and INSTALL_PP_FILES to 'auto')
INSTALL_FILES := auto
INSTALL_PP_FILES := auto
endif
endif

# ignore these files while generating file list
IGNORE_FILES ?=

ifeq ($(INSTALL_FILES), auto)
$(info Generating INSTALL_FILES list)
INSTALL_FILES := $(shell find . -mindepth 1 -type f -not -name '*.pp')
$(info > $(INSTALL_FILES))
endif

ifeq ($(INSTALL_PP_FILES), auto)
$(info Generating INSTALL_PP_FILES list)
INSTALL_PP_FILES := $(shell find . -mindepth 1 -type f -name '*.pp')
$(info > $(INSTALL_PP_FILES))
endif

# "repair" paths
$(info Repairing pathnames)
INSTALL_FILES := $(subst $(PWD)/,, $(realpath $(INSTALL_FILES)))
INSTALL_PP_FILES := $(subst $(PWD)/,, $(realpath $(INSTALL_PP_FILES)))
$(info > $(INSTALL_FILES) $(INSTALL_PP_FILES))

# remove ignored files
$(info Removing ignored files)
INSTALL_FILES := $(filter-out $(FORCE_IGNORE) $(IGNORE_FILES), $(INSTALL_FILES))
INSTALL_PP_FILES := $(filter-out $(FORCE_IGNORE) $(IGNORE_FILES), $(INSTALL_PP_FILES))
$(info > $(INSTALL_FILES) $(INSTALL_PP_FILES))

# get the directory-list (we need them to be created at first)
$(info Adding directories to INSTALL_DIRS)
INSTALL_DIRS += $(subst ./,, $(dir $(INSTALL_FILES) $(INSTALL_PP_FILES)))
INSTALL_DIRS := $(sort $(INSTALL_DIRS))
$(info > $(INSTALL_DIRS))

build:: clean outdir defines $(INSTALL_DIRS) $(INSTALL_FILES) $(INSTALL_PP_FILES) post_build

post_build:: FORCE

post_install:: FORCE

$(INSTALL_DIRS): FORCE
	mkdir -p "$(ODIR)/$(ODIR_SUBDIR)/$(RESULT_FILE_PREFIX)$@"

$(INSTALL_FILES): FORCE
	cp "$@" "$(ODIR)/$(ODIR_SUBDIR)/$(RESULT_FILE_PREFIX)$@"

$(INSTALL_PP_FILES): FORCE
	$(PP) $(PP_DEFINES) $(PP_MODULES) -kc "$(PP_KC)" "$@" -o "$(ODIR)/$(ODIR_SUBDIR)/$(RESULT_FILE_PREFIX)$(subst .pp,,$@)"

install: post_install
	(\
	 cd "$(ODIR)"; \
	 find . -mindepth 1 -type d -exec mkdir -p "$(DEST)/{}" \;; \
	 find . -mindepth 1 -type f -exec cp {} "$(DEST)/{}" \; \
	)

defines:
	$(call setup_defines)

outdir:
	mkdir -p "$(ODIR)/$(ODIR_SUBDIR)"

clean:
	rm -rf "$(ODIR)"

# we use this to force building a target
FORCE:
