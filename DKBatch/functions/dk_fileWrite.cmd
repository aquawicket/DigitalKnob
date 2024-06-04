@echo off
call DK

::##################################################################################
::# dk_fileWrite(<file> <string>)
::#
::#
:dk_fileWrite () {
	call dk_debugFunc
	echo "dk_fileWrite %*"
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGS__%): incorrect number of arguments")
	setlocal
	
	echo %~2 > "%~1"
	
	endlocal
goto:eof




:DKTEST ########################################################################
	
	call dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
