@echo off
call DK.cmd

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    cls
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
