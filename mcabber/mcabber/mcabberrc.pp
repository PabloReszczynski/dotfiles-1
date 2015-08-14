# Config #######################################################################
set lang = de
set time_prefix = 1
set cmdhistory_lines = 1000
set escdelay = 50
set ignore_self_presence = 0
set use_mouse = 0

set jid = JID
set password = PASSWORD
set nickname = NICK
set port = PORT
set disable_random_ressource = 1
set ressource = mcabber
set priority = 42
set priority_away = 23
set tls = 1

set iq_version_hide_os = 0
set iq_last_disable = 1

# Autoaway
#set autoaway = 3600
#set message_autoaway = "Ich bin nicht da!"

# Style
set log_win_height =  1
set roster_width = 20
set log_win_on_top = 1
set roster_win_on_right = 0
set roster_display_filter = ofdna

# Muc-Colors
set nick_colors = red brightred brightgreen yellow brightyellow magenta brightmagenta cyan brightcyan brightblue
color muc * on

# Hooks
#set hook-post-connect = status online Online
#set hook-pre-disconnect = status offline Byebye

# URL-Regex
set url_regex = "(((http|ftp)s?://)|www[.][-a-z0-9.]+|(mailto:|news:))(%[0-9A-F]{2}|[-_.!~*';/?:@&=+$,#[:alnum:]])+"

# Modules ######################################################################
#module load tune
#module load mpd

# History ######################################################################
set logging = 1
set load_logs = 1
set logging_dir = ~/.mcabber/history
set logging_ignore_status = 0
set log_muc_conf = 1
set load_muc_logs = 1
set max_history_age = 7 # laod history of 1 week

# state file only makes sense with history
set statefile = ~/.mcabber/statefile

# Events #######################################################################
set events_command = ~/.mcabber/event.pl
set event_log_files = 1
set event_log_dir = /tmp
set eventcmd_use_nickname = 1

# OTR ##########################################################################
set otr = 1
set otr_dir = ~/.mcabber/otr
# enable OTR for all contacts
otrpolicy * opportunistic

# FIFO #########################################################################
set fifo_name = ~/.mcabber/fifo
set fifo_hide_commands = 0
set fifo_ignore = 0

# Aliases ######################################################################
alias me = say /me

alias join_arch = room join arch@conference.draugr.de
alias join_debian = room join debianforum.de@chat.debianforum.de
alias join_draugr = room join chat@conference.draugr.de
alias join_fishmixx = room join fishmixx@conference.draugr.de
alias join_metalheadz = room join metalheadz@conference.verdammung.org
alias join_ubuntu = room join ubuntu@conference.ubuntu-jabber.de
alias join_uhuc = room join chat@conference.uhuc.de
alias join_mcabber = room join mcabber@conf.lilotux.net

#> include "theme"
#> include "keymap"
