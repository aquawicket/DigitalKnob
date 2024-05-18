@echo off
call DK

::################################################################################
::# dk_getExtension(<path> <output>)
::#
::#
:dk_getExtension () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")

	setlocal enabledelayedexpansion
	set "_input=%1"
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~xZ"
	endlocal & set %2=%OUT%
goto:eof




:DKTEST ########################################################################

	set "filepath=/test/test2/xfile.extension"
	call dk_getExtension "%filepath%" extension
	echo extension = %extension%