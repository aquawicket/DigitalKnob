@echo off
call dk_includeGuard
call DK

::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
dk_keepConsoleOpen
	call dk_debugFunc
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
goto:eof