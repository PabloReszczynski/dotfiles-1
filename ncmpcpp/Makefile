DEST = $(HOME)

# <parameters>
COLOR = blue
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES =

PP_DEFINES = \
	-DCOLOR=$(COLOR)
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) config.pp -o config
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) bindings.pp -o bindings

	@echo "Adding dummy bindings"
	./makeDummyBindings.sh >> bindings

install:
	mkdir -p $(DEST)/.ncmpcpp
	cp config $(DEST)/.ncmpcpp
	cp bindings $(DEST)/.ncmpcpp
