DEST = $(HOME)

# <parameters>
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES =

PP_DEFINES =
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) bashrc -o .bashrc

install:
	cp .bashrc $(DEST)
