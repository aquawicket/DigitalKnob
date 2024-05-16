@echo off
call DK

::################################################################################
::# dk_getDirectory(<path> <output>)
::#
::#
:dk_getDirectory () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
		set "_input_=%1"
		set "_input_=%_input_:"=%"
		if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
		if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
		for %%Z in ("%_input_%") do set "OUT=%%~dpZ"
	endlocal & set "%2=%OUT:~0,-1%"
goto:eof




:DKTEST ########################################################################

	call dk_getDirectory "C:\Windows\System32" result
	call dk_printVar result