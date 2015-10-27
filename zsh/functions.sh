getAlias() {
   local definedAlias;

   definedAlias=$(alias "$1") || { echo "$1"; return 1; }
   definedAlias=${definedAlias##$1=\'}
   definedAlias=${definedAlias%%\'}

   echo "$definedAlias"
}

uri_escape() {
   perl -MURI::Escape=uri_escape -ne 'print uri_escape($_)';
}

uri_unescape() {
   perl -MURI::Escape=uri_unescape -ne 'print uri_unescape($_)';
}

escapeshellarg() {
   printf '%q' "$@"
}

vimake() {
   vim +"set noexpandtab" "${@:-Makefile}"
}

mysql_date()
{
   date "+%Y-%m-%d %H:%M:%S" "$@"
}

hdplayer()
{
   nice -n 0 -- \
   mplayer \
      -vfm ffmpeg \
      -lavdopts lowres=0:fast:skiploopfilter=all:threads=8 \
      -framedrop \
      "$@"
}

getip()
{
   curl 'http://ifconfig.me/ip'
}

lndir()
{
   if ! which lndir &>/dev/null; then
      echo "No 'lndir' executable found"
      return 1
   fi

   if (( $# > 2 )); then
      if [[ "$1" == "-p" ]]; then
         mkdir -p "$2";
         shift 2;
      fi
   fi

   command lndir "$@"
}
