@echo off
call DK

::##################################################################################
::# dk_appendFile(string, file)
::#
::#
:dk_appendFile () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	if exist "%~2" (
		echo %~1 >> "%~2"
	) else (
		echo %~1 > "%~2"
	)
goto:eof




:DKTEST ########################################################################
	
	echo call dk_appendFile "appended string" "%DKSCRIPT_DIR%\appendFile_TEST.txt"
	call dk_appendFile "appended string" "%DKSCRIPT_DIR%\appendFile_TEST.txt"
