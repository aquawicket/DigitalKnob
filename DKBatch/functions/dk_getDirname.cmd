@echo off
call DK.cmd

::################################################################################
::# dk_getDirname(path rtn_var)
::#
::#   https://en.wikipedia.org/wiki/Dirname
::#
:dk_getDirname () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
		set "_input_=%1"
		set "_input_=%_input_:"=%"
		if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
		if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
		for %%Z in ("%_input_%") do set "OUT=%%~dpZ"
	endlocal & call dk_set %2 "%OUT:~0,-1%"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_getDirname "C:\Windows\System32" result
	call dk_printVar result