# ls ##########################################################################
#> define $LS_OPTS --color=auto
alias ls="ls $LS_OPTS"
alias  l="ls $LS_OPTS -la"
alias ll="ls $LS_OPTS -l"
alias la="ls $LS_OPTS -A"

# grep ########################################################################
#> define $GREP_OPTS --color=auto
alias grep="grep $GREP_OPTS"
alias fgrep="grep $GREP_OPTS -F"
alias igrep="grep $GREP_OPTS -i"
alias egrep="grep $GREP_OPTS -E"

# Be Verbose/Interactive/Safe #################################################
alias cp="cp -v -p -i" # preserve owner and rights
alias rm="rm -v --preserve-root"
alias mv="mv -v -i"
alias mkdir="mkdir -v"
alias rmdir="rmdir -v"
alias chmod='chmod -v --preserve-root'
alias chown='chown -v --preserve-root'
alias ln='ln -v -i'

# Don't create the annoying ~/.xsel.log file ##################################
alias xsel="xsel -l /dev/null"

# cd-aliases ##################################################################
#> define $CD_COMMAND pushd
alias      ..="$CD_COMMAND .."
alias     ...="$CD_COMMAND ../.."
alias    ....="$CD_COMMAND ../../.."
alias   .....="$CD_COMMAND ../../../.."
alias  ......="$CD_COMMAND ../../../../.."
alias .......="$CD_COMMAND ../../../../../.."
alias -- -="$CD_COMMAND"

# vi aliases ##################################################################
alias vi='vim'
alias vimake='vim +"set noexpandtab" Makefile'

# misc aliases ################################################################
alias less='less -iM'
alias more='less -iM'
alias info='info --vi-keys'
alias man="man -r ' Manual page \$MAN_PN line %lt?L/%L.:byte %bB?s/%s..? (END):?pB %pB\\%.. '"

alias openports='netstat --all --numeric --programs --inet'
alias killflash="pkill -f flash"
alias dis='bg;disown'

#for c in ls mv rm cp cat grep; do
#   colorize_remark $c
#done

# if which grc; then
# for f in /usr/share/grc/*; do
# f=${f##*/};
# f=${f##conf.};
# 
# case "$f" in
# ls) continue;;
# esac
# 
# alias $f="grc $(getAlias $f)"
# done
# fi
