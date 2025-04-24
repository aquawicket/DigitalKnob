@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_contains(<haystack>, <needle>, <ret:optional>)
::#
::#
:dk_contains
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 3

	set "_haystack_=%~1"
	set "_needle_=%~2"
	
	if not "XXX!_haystack_:%_needle_%=!XXX" equ "XXX%_haystack_%XXX" (
		set "_haystack_="
		set "_needle_="
		endlocal & (
			set "dk_contains=true"
			if "%~3" neq "" (set "%~3=true")
		)
		exit /b 0
	)

	set "_haystack_="
	set "_needle_="
	endlocal & (
		set "dk_contains=false"
		if "%~3" neq "" (set "%3=false")
	)
	exit /b 1
%endfunction%












::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal   
	%dk_call% dk_debugFunc 0

	::###### Using dk_contains return value
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%"
	if "%dk_contains%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%"
	if "%dk_contains%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1 

	::###### Using user defined return value
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%" myResult
	if "%myResult%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%" myResult
	if "%myResult%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1 

	::###### Using if ERRORLEVEL
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%"
	if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%"
	if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1 


	::###### Using && and || conditionals
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
	::FIXME: ERRORLEVEL is still 1
%endfunction%
