DEST = $(HOME)

# <parameters>
THEME_COLOR = blue
NICK = braph
JID = insert_jid_here
PASSWORD = insert_pw_here
PORT = 5222
# </parameters>

# <filepp>
PP_KC = \#>

PP_MODULES = -M ../filepp_modules -m ord.pm -m maths.pm

PP_DEFINES = \
	-DTHEME_COLOR=$(THEME_COLOR) \
	-DJID=$(JID) \
	-DPASSWORD=$(PASSWORD) \
	-DPORT=$(PORT) \
	-DNICK=$(NICK)
# </filepp>

all:
	mkdir -p .mcabber
	mkdir -p .mcabber/history
	mkdir -p .mcabber/otr
	cp mcabber/event.pl .mcabber
	mkfifo .mcabber/fifo
	
	filepp -kc '$(PP_KC)' $(PP_MODULES) $(PP_DEFINES) mcabber/mcabberrc -o .mcabber/mcabberrc

install:
	cp .mcabber $(DEST)
