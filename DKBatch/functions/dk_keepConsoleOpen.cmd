::dk_includeGuard()
@echo off

::#################################################################################
:: dk_keepConsoleOpen()
::
::
dk_keepConsoleOpen
	call dk_debugFunc
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %SCRIPT_PATH%) & exit ) :: keep window open
goto:eof