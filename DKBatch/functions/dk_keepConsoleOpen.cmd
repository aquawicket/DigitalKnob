@echo off
call DK.cmd

::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
dk_keepConsoleOpen
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
goto:eof