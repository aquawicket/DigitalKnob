@echo off
call DK

::################################################################################
::# dk_color()
::#
::#   reference: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
:dk_color () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	:::::: STYLES ::::::
	call dk_set clr [0m
	call dk_set bold [1m
	call dk_set underline [4m
	call dk_set inverse [7m

	:: Foreground Colors
	call dk_set black [30m
	call dk_set red [31m
	call dk_set green [32m
	call dk_set yellow [33m
	call dk_set blue [34m
	call dk_set magenta [35m
	call dk_set cyan [36m
	call dk_set white [37m

	:: Background Colors
	call dk_set bg_black [40m
	call dk_set bg_red [41m
	call dk_set bg_green [42m
	call dk_set bg_yellow [43m
	call dk_set bg_blue [44m
	call dk_set bg_magenta [45m
	call dk_set bg_cyan [46m
	call dk_set bg_white [47m

	:: Foreground Colors (Bright)
	call dk_set Black [90m
	call dk_set Red [91m
	call dk_set Green [92m
	call dk_set Yellow [93m
	call dk_set Blue [94m
	call dk_set Magenta [95m
	call dk_set Cyan [96m
	call dk_set White [97m

	:: Background Colors (Bright)
	call dk_set BG_Black [100m
	call dk_set BG_Red [101m
	call dk_set BG_Green [102m
	call dk_set BG_Yellow [103m
	call dk_set BG_Blue [104m
	call dk_set BG_Magenta [105m
	call dk_set BG_Cyan [106m
	call dk_set BG_White [107m

goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_color