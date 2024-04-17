:: dk_include_guard()
:: call dk_verbose "%0(%*)"

:::::: STYLES ::::::
set "clr=[0m"
set "bold=[1m"
set "underline=[4m"
set "inverse=[7m"
	
:::::: NORMAL FOREGROUND COLORS ::::::
set "black=[30m"
set "red=[31m"
set "green=[32m"
set "yellow=[33m"
set "blue=[34m"
set "magenta=[35m"
set "cyan=[36m"
set "white=[37m"

:::::: NORMAL BACKGROUND COLORS ::::::
set "bg_black=[40m"
set "bg_red=[41m"
set "bg_green=[42m"
set "bg_yellow=[43m"
set "bg_blue=[44m"
set "bg_magenta=[45m"
set "bg_cyan=[46m"
set "bg_white=[47m"

:::::: STRONG FOREGROUND COLORS ::::::
set "BLACK=[90m"
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "MAGENTA=[95m"
set "CYAN=[96m"
set "WHITE=[97m"

:::::: STRONG BACKGROUND COLORS ::::::
set "BG_BLACK=[100m"
set "BG_RED=[101m"
set "BG_GREEN=[102m"
set "BG_YELLOW=[103m"
set "BG_BLUE=[104m"
set "BG_MAGENTA=[105m"
set "BG_CYAN=[106m"
set "BG_WHITE=[107m"


:::::::::::::::::::::::::::::::::::::::::::::
:: dk_color () {
::
::
::
:dk_color () {
    ::call dk_verbose "%0(%*)"
    ::call :dk_print_colors
goto:eof

