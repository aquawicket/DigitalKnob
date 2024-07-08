@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_fileWrite(file, string)
::#
::#
:dk_fileWrite
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%(%__ARGS__%): incorrect number of arguments")
	
	setlocal
	echo %~2 > "%~1"
	endlocal
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
goto:eof
