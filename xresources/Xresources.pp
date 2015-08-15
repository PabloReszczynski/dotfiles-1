#> include COLOR_THEME

#> foreach TERM xterm,URxvt

TERM*utf8:      2
TERM*eightBitInput: true
TERM*VT100.geomentry: 120x50

! Scrollbar
TERM*scrollBar: false
TERM*saveLines: 0

!TERM*.font:    xft:DejaVu Sans Mono:pixelsize=12 
TERM*faceName:  Terminus:style=Regular:size=14

! Background/Foreground
TERM*background: rgb:00/00/00
TERM*foreground: rgb:7f/7f/7f

! Cursor
TERM*cursorColor: Red
TERM*cursorBlink: true

! Title
TERM*title: Terminal

#> endforeach
