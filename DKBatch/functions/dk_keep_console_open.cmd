::dk_include_guard()
@echo off

::#################################################################################
:: dk_keep_console_open()
::
::
dk_keep_console_open
	call dk_verbose "%0(%*)"
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %*) & exit ) :: keep window open
goto:eof