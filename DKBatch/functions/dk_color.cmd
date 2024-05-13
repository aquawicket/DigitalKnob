@echo off
call DK

::################################################################################
::# dk_color()
::#
::#   reference: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
:dk_color () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	:::::: STYLES ::::::
	set "clr=[0m"
	set "bold=[1m"
	set "underline=[4m"
	set "inverse=[7m"
		
	:: Foreground Colors
	set "black=[30m"
	set "red=[31m"
	set "green=[32m"
	set "yellow=[33m"
	set "blue=[34m"
	set "magenta=[35m"
	set "cyan=[36m"
	set "white=[37m"

	:: Background Colors
	set "bg_black=[40m"
	set "bg_red=[41m"
	set "bg_green=[42m"
	set "bg_yellow=[43m"
	set "bg_blue=[44m"
	set "bg_magenta=[45m"
	set "bg_cyan=[46m"
	set "bg_white=[47m"

	:: Foreground Colors (Bright)
	set "Black=[90m"
	set "Red=[91m"
	set "Green=[92m"
	set "Yellow=[93m"
	set "Blue=[94m"
	set "Magenta=[95m"
	set "Cyan=[96m"
	set "White=[97m"

	:: Background Colors (Bright)
	set "BG_Black=[100m"
	set "BG_Red=[101m"
	set "BG_Green=[102m"
	set "BG_Yellow=[103m"
	set "BG_Blue=[104m"
	set "BG_Magenta=[105m"
	set "BG_Cyan=[106m"
	set "BG_White=[107m"

goto:eof




:DKTEST ########################################################################
