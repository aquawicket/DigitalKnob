@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_stringContains(<haystack> <needle> rtn_var)
::#
::#
:dk_stringContains
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal enableDelayedExpansion
    call dk_set _haystack_ "%~1"
    call dk_set _needle_ "%~2"
    if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
		if defined "%~3" (endlocal & call dk_set %3 true)
		(call )
		goto:eof
	)
	
    if defined "%~3" (endlocal & call dk_set %3 false)
    (call)
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    ::###### Using if return value
	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (echo string contains substring) else (echo string does NOT contain substring)
	
	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (echo string contains substring) else (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (echo string contains substring) else (echo string does NOT contain substring)
	
	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (echo string contains substring) else (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=needle"
	call dk_stringContains "%string%" "%substring%" && (echo string contains substring) || (echo string does NOT contain substring)

	call dk_echo
	set "string=There is a needle in this haystack"
	set "substring=straw"
	call dk_stringContains "%string%" "%substring%" && (echo string contains substring) || (echo string does NOT contain substring)
	::FIXME: ERRORLEVEL is still 1
goto:eof
