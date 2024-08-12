@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_stringContains(haystack, needle, rtn_var)
::#
::#
:dk_stringContains
	call dk_debugFunc 2 3
	
	setlocal enableDelayedExpansion
	if "!!" neq "" call dk_error "%__FUNCTION__% requires delayed expansion"
	
    set "_haystack_=%~1"
    set "_needle_=%~2"
    if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
		if defined "%~3" (endlocal & set "%3=true")
		(call )
		goto:eof
	)
	
    if defined "%~3" (endlocal & set "%3=false")
    (call)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    ::###### Using if return value
	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "needle"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (call dk_echo "string contains substring") else (call dk_echo "string does NOT contain substring")
	
	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "straw"
	call dk_stringContains "%string%" "%substring%" result
	if "%result%" equ "true" (call dk_echo "string contains substring") else (call dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "needle"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (call dk_echo "string contains substring") else (call dk_echo "string does NOT contain substring")
	
	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "straw"
	call dk_stringContains "%string%" "%substring%"
	if not ERRORLEVEL 1 (call dk_echo "string contains substring") else (call dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "needle"
	call dk_stringContains "%string%" "%substring%" && (call dk_echo "string contains substring") || (call dk_echo "string does NOT contain substring")

	call dk_echo
	call dk_set string "There is a needle in this haystack"
	call dk_set substring "straw"
	call dk_stringContains "%string%" "%substring%" && (call dk_echo "string contains substring") || (call dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1
goto:eof
