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
