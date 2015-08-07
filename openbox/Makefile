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
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) openbox/rc.xml -o rc.xml

install:
	mkdir -p $(DEST)/.config/openbox
	cp rc.xml $(DEST)/.config/openbox
	which openbox && openbox --reconfigure
