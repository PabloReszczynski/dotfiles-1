! ======== General Terminal Settings ===========
#> foreach TERM xterm, URxvt

! Cursor
TERM*cursorColor: Red
TERM*cursorBlink: true

! Title
TERM*title: Terminal

! Fixes ALT-Key
TERM*metaSendsEscape: true

! Disable changing window title
TERM*allowTitleOps: false

! UTF-8 Stuff
TERM*utf8:            2
TERM*eightBitInput:   true

! Geometry
TERM*geomentry: 120x80

! Scrollbar
TERM*scrollBar: false
TERM*saveLines: 0

! Font
TERM*faceName:  Hack:size=12
!TERM*.font:    xft:DejaVu Sans Mono:pixelsize=12 

! === Color Scheme ===
! Import scheme from themes/
#> include COLOR_THEME
! Overwrite Background/Foreground
TERM*background: #111111
TERM*foreground: #EEEEEE
! ====================

#> endforeach
! ============================================

! === URxvt ====
URxvt.font: xft:Hack:size=12
URxvt.letterSpace: -1
URxvt*buffered: false
! ==============

! === Font ===
Xft.antialias: 1
Xft.autohint: 0
Xft.dpi: 96
Xft.hinting: 1
!Xft.hintstyle: hintfull
Xft.hintstyle: hintslight
Xft.lcdfilter: lcddefault
Xft.rgba: rgb
! ============

