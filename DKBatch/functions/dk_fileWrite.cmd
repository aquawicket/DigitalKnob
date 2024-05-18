@echo off
call DK

::##################################################################################
::# dk_fileWrite(<file> <string>)
::#
::#
:dk_fileWrite () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	echo %~2 > "%~1"
goto:eof




:DKTEST ########################################################################
	
	call dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
