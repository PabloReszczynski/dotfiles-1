# Consider using xbindkeys instead, if you don't need
# per application settings

#> ifndef SCROLL_BROWSER_LINES
#> define SCROLL_BROWSER_LINES 1
#> endif
#
#> ifndef SCROLL_BROWSER_LINES_SHIFT
#> define SCROLL_BROWSER_LINES_SHIFT 1
#> endif

"^.*- (Palemoon|Firefox|Chromium|Inox)$"
Control_L,  Up,   Control_L|plus 
Control_L,  Down, Control_L|minus
Shift_L,    Up,   Button4, SCROLL_BROWSER_LINES_SHIFT
Shift_L,    Down, Button5, SCROLL_BROWSER_LINES_SHIFT
None,       Up,   Button4, SCROLL_BROWSER_LINES
None,       Down, Button5, SCROLL_BROWSER_LINES

".*"
None, Thumb2, Page_Up
None, Thumb1, Page_Down
