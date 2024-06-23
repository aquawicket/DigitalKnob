@echo off
call DK.cmd

::################################################################################
::# dk_getBasename(path rtn_var)
::#
::#    https://en.wikipedia.org/wiki/Basename
::#
:dk_getBasename () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input=%_input_:~0,-1%"
	for %%Z in ("%_input_%") do set "basename=%%~nxZ"
	endlocal & call dk_set %2 "%basename%"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_getBasename C:\Windows\System32\test.v123.zip name
	echo name = %name%
	
	call dk_getBasename TEST nameb
	echo nameb = %nameb%