@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_fileAppend(<file> string)
::#
::#
:dk_fileAppend
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if exist "%~1" (
		echo %~2 >> "%~1"
	) else (
		echo %~2 > "%~1"
	)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
goto:eof
