#> define COLOR(_C_) $'\033'"[${color[_C_]}m"

autoload -U colors && colors;

COLOR_BLACK=COLOR(black);
COLOR_RED=COLOR(red);
COLOR_GREEN=COLOR(green);
COLOR_YELLOW=COLOR(yellow);
COLOR_BLUE=COLOR(blue);
COLOR_MAGENTA=COLOR(magenta);
COLOR_CYAN=COLOR(cyan);
COLOR_WHITE=COLOR(white);

COLOR_BG_BLACK=COLOR(bg-black);
COLOR_BG_RED=COLOR(bg-red);
COLOR_BG_GREEN=COLOR(bg-green);
COLOR_BG_YELLOW=COLOR(bg-yellow);
COLOR_BG_BLUE=COLOR(bg-blue);
COLOR_BG_MAGENTA=COLOR(bg-magenta);
COLOR_BG_CYAN=COLOR(bg-cyan);
COLOR_BG_WHITE=COLOR(bg-white);

COLOR_BOLD=COLOR(bold);
COLOR_NONE=COLOR(none);
