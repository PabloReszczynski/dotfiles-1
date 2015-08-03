# used by precmd() and preexec()
LAST_COMMAND="none"

date
echo

#> if "SLOW_SYSTEM" == 0
fortune 2>/dev/null || :
echo
#> endif
