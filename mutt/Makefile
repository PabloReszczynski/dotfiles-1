DEST = $(HOME)

# <parameters>
HEADER_CACHE = header_cache
REALNAME = Real Name
EMAIL = email@example.com
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES =

PP_DEFINES = \
	-DHEADER_CACHE="$(HEADER_CACHE)" \
	-DREALNAME="$(REALNAME)" \
	-DEMAIL="$(EMAIL)"
# </filepp>

all:
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) mutt/muttrc -o muttrc

install:
	mkdir -p $(DEST)/.mutt
	mkdir -p $(DEST)/.mutt/$(HEADER_CACHE)
	cp muttrc $(DEST)/.mutt/
