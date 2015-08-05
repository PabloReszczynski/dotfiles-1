DEST = $(HOME)

# <parameters>
THEME_COLOR = blue
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES =

PP_DEFINES = \
	-DTHEME_COLOR=$(THEME_COLOR)
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) abook/abookrc -o abookrc

install:
	mkdir -p $(DEST)/.abook
	cp abookrc $(DEST)/.abook
