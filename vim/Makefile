DEST = $(HOME)

# <parameters>
SLOW_SYSTEM = 0
# </parameters>

# <filepp>
PP_KC = \">

PP_MODULES =

PP_DEFINES = \
	-DSLOW_SYSTEM=$(SLOW_SYSTEM)
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) vimrc -o .vimrc

install:
	cp .vimrc $(DEST)
	cp -r vim $(DEST)/.vim
