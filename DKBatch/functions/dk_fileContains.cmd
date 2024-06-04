@echo off
call DK

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
		
	call dk_fileToVariable %~1 _fileVar_
	
	setlocal enableDelayedExpansion
    call set "_haystack_=%_fileVar_%"
    call set "_needle_=%~2"
    if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
		if defined "%~3" (endlocal & call dk_set %3 true)
		(call )
		goto:eof
	)
	
    if defined "%~3" (endlocal & call dk_set %3 false)
    (call)
goto:eof



:DKTEST ########################################################################

:: https://stackoverflow.com/a/3069068

	call dk_fileAppend fileContains_TEST.txt "find the needle in the haystack"
	
	echo.
	call dk_set substring needle
	call dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
	echo.
	call dk_set substring "not_in_file"
	call dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
