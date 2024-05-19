@echo off
call DK

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
		
	call dk_fileToVariable %~1 _fileVar_
	
	setlocal enableDelayedExpansion
    call set "_haystack_=%_fileVar_%"
    call set "_needle_=%~2"
    if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
		if not defined "%~2" goto:eof
		
		endlocal & set "%3=true"
		call dk_printVar "%3"
		(call )
		goto:eof
	)
	
    if not defined "%~3" goto:eof
	
	endlocal & set "%3=false"
	call dk_printVar "%3"
    (call)
goto:eof



:DKTEST ########################################################################

:: https://stackoverflow.com/a/3069068

	call dk_appendFile "find the needle in the haystack" fileContains_TEST.txt
	
	set "string=fileContains_TEST.txt"
	set "substring=needle"
	call dk_fileContains "%string%" "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
	set "string=fileContains_TEST.txt"
	set "substring=not_in_file"
	call dk_fileContains "%string%" "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
