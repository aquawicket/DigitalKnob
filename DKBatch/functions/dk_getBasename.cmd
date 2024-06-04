@echo off
call DK

::################################################################################
::# dk_getBasename(<path> <rtn_var>)
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
	for %%Z in ("%_input_%") do set "OUT=%%~nZ"
	endlocal & call dk_set %2 "%OUT%"
goto:eof




:DKTEST ########################################################################

	call dk_getBasename C:\Windows\System32 name
	echo name = %name%
	
	call dk_getBasename TEST nameb
	echo nameb = %nameb%