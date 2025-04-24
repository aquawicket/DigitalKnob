<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_includes(haystack, needle, rtn_var)
::#
::#
:dk_includes
    call dk_debugFunc 2 3
 setlocal enableDelayedExpansion
 
    if "!d!" neq "" %dk_call% dk_error "%__FUNCTION__%: requires delayed expansion"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_includes(<haystack>, <needle>, <ret>:optional)
::#
::#
:dk_includes
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 3
>>>>>>> Development
    
    set "_haystack_=%~1"
    set "_needle_=%~2"
	
<<<<<<< HEAD
	if not "x!_haystack_:%_needle_%=!"=="x%_haystack_%" (
        if "%~3" neq "" (endlocal & set "%3=true")
		set "_haystack_="
		set "_needle_="
        exit /b 0
    )
    
    if "%~3" neq "" (endlocal & set "%3=false")
	set "_haystack_="
	set "_needle_="
    exit /b 1
=======
	if not "x!_haystack_:%_needle_%=!" equ "x%_haystack_%" (
		set "dk_includes=0"
	) else (
		set "dk_includes=1"
	)
    
	set "_haystack_="
	set "_needle_="
    endlocal & (
		set "dk_includes=%dk_includes%"
		if "%~3" neq "" (set "%~3=%dk_includes%")
		exit /b !dk_includes!
	)
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
  setlocal   
=======
setlocal
    %dk_call% dk_debugFunc 0

>>>>>>> Development
    ::###### Using if return value
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_includes "%string%" "%substring%" result
<<<<<<< HEAD
    if "%result%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
=======
    if %result% equ 0 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_includes "%string%" "%substring%" result
<<<<<<< HEAD
    if "%result%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
=======
    if %result% equ 0 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_includes "%string%" "%substring%"
<<<<<<< HEAD
    if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
=======
    if not ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_includes "%string%" "%substring%"
<<<<<<< HEAD
    if not ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
=======
    if not ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
<<<<<<< HEAD
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
=======
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development

    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
<<<<<<< HEAD
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
=======
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1
	
	::###### Using && and || conditionals
    %dk_call% dk_echo
<<<<<<< HEAD
    %dk_call% dk_includes "There is a needle in this haystack" "needle" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")

    %dk_call% dk_echo
    %dk_call% dk_includes "There is a needle in this haystack" "straw" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
=======
	echo dk_includes "There is a needle in this haystack" "needle"
    %dk_call% dk_includes "There is a needle in this haystack" "needle" && (%dk_call% dk_echo "There is a needle in this haystack' CONTAINS 'needle'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'needle'")

    %dk_call% dk_echo
	echo dk_includes "There is a needle in this haystack" "straw"
    %dk_call% dk_includes "There is a needle in this haystack" "straw" && (%dk_call% dk_echo "'There is a needle in this haystack' CONTAINS 'straw'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'straw'")
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1
%endfunction%
