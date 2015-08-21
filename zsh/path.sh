#> define IF_DIR(_IF_, _THEN_) [[ -d "_IF_" ]] && _THEN_

#> define PREPEND_PATH(_DIR_) PATH="_DIR_:$PATH"
#> define APPEND_PATH(_DIR_)  PATH=+"_DIR_"

#> define IF_PREPEND(_DIR_) IF_DIR(_DIR_, PREPEND_PATH(_DIR_))
#> define IF_APPEND(_DIR_)  IF_DIR(_DIR_, APPEND_PATH(_DIR_))

export PATH='/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/games:/opt'

IF_PREPEND($HOME/bin)
IF_PREPEND($HOME/scripts)
IF_PREPEND(/usr/bin/core_perl)
IF_PREPEND(/usr/bin/vendor_perl)

# TODO: implement own if-file-exists-module?
