@echo off
call DK

::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
dk_keepConsoleOpen
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
goto:eof