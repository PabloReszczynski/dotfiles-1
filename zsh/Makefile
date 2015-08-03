DEST = $(HOME)

# <parameters>
LANGUAGE = en_US.UTF-8
SLOW_SYSTEM = 0
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES =

PP_DEFINES = \
	-DLANGUAGE=$(LANGUAGE) \
	-DSLOW_SYSTEM=$(SLOW_SYSTEM)
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) zshrc -o .zshrc

	@echo "Removing comments"
	sed -i '/^#/d' .zshrc

	@echo "Removing empty lines"
	sed -i '/^$$/d' .zshrc

install:
	cp .zshrc $(DEST)
