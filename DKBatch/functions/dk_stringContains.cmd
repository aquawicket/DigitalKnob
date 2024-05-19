@echo off
call DK

::################################################################################
::# dk_stringContains(<haystack> <needle> <result>)
::#
::#
:dk_stringContains () {
	call dk_debugFunc
	::if %__ARGC__% NEQ 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
    call set "_haystack_=%~1"
    call set "_needle_=%~2"
    if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
		if not defined "%~2" goto:eof
		
		endlocal & set "%3=true"
		call dk_printVar "%3"
		(call )
		goto:eof
	)
	
    if not defined "%~2" goto:eof
	
	endlocal & set "%3=false"
	call dk_printVar "%3"
    (call)
goto:eof





:DKTEST ########################################################################

    ::###### Using if return value
	echo.
	
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (echo string contains substring) else (echo string does NOT contain substring)
	
	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (echo string contains substring) else (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (echo string contains substring) else (echo string does NOT contain substring)
	
	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (echo string contains substring) else (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%" && (echo string contains substring) || (echo string does NOT contain substring)

	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%" && (echo string contains substring) || (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1