@echo off
call DK

::##################################################################################
::# dk_fileAppend(<file> <string>)
::#
::#
:dk_fileAppend () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	if exist "%~1" (
		echo %~2 >> "%~1"
	) else (
		echo %~2 > "%~1"
	)
goto:eof




:DKTEST ########################################################################
	
	call dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
