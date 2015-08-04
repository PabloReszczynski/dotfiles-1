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
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) tmux.conf -o .tmux.conf

install:
	cp .tmux.conf $(DEST)
	
	mkdir -p $(DEST)/.tmux/bin
	cp -r tmux/bin/* $(DEST)/.tmux/bin
