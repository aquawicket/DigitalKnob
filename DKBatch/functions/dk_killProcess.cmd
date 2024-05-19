@echo off
call DK

::################################################################################
::# dk_killProcess(<name>)
::#
::#
:dk_killProcess () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    taskkill /IM "%1" /F > nul
goto:eof