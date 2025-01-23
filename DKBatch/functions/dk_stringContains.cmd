@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_stringContains(haystack, needle, rtn_var)
::#
::#
:dk_stringContains
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 3
 
	set "_haystack_=%~1"
    set "_needle_=%~2"
	
	if not "XXX!_haystack_:%_needle_%=!XXX"=="XXX%_haystack_%XXX" (
        if "%~3" neq "" (endlocal & set "%3=true")
		set "_haystack_="
		set "_needle_="
        exit /b 0
    )
    
    if "%~3" neq "" (endlocal & set "%3=false")
	set "_haystack_="
	set "_needle_="
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal   
    %dk_call% dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_stringContains "%string%" "%substring%" result
    if "%result%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_stringContains "%string%" "%substring%" result
    if "%result%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_stringContains "%string%" "%substring%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_stringContains "%string%" "%substring%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_stringContains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")

    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_stringContains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
    ::FIXME: ERRORLEVEL is still 1
%endfunction%
