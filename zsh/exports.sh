# Read .pythonrc when python starts in interactive mode #######################
export PYTHONSTARTUP=~/.pythonrc

# Color for Grep-Matching #####################################################
export GREP_COLORS="ms=01;31:mc=01;31:sl=${color[blue]}:cx=:fn=35:ln=32:bn=32:se=36"

# bc calculator: quite, with math lib
export BC_ENV_ARGS="-l -q"

# Color for Manpages ##########################################################
export LESS_TERMCAP_md=$COLOR_BLUE$COLOR_BOLD
export LESS_TERMCAP_me=$COLOR_NONE

export LESS_TERMCAP_so=$COLOR_WHITE$COLOR_BG_BLUE
export LESS_TERMCAP_se=$COLOR_NONE

export LESS_TERMCAP_us=$COLOR_GREEN
export LESS_TERMCAP_ue=$COLOR_NONE
# see man termcap:
#	[...]
#       md   Start bold mode
#       me   End all mode like so, us, mb, md and mr
#       so   Start standout mode
#       se   End standout mode
#       us   Start underlining
#       ue   End underlining
#	[...]

# we don't need a history in less #############################################
export LESSHISTFILE=-

# Set default X11 display: ####################################################
if [[ -z "$DISPLAY" ]] ; then
   export DISPLAY=:0
fi

# Set default editor ##########################################################
export EDITOR=vim

# Yaourt: build PKGBUILDS on arm devices ######################################
export MAKEPKG=makepkg_pre.sh
