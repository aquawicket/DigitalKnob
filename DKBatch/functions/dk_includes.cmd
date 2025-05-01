@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_includes(<haystack>, <needle>, <ret>:optional)
::#
::#
:dk_includes
%setlocal%
	%dk_call% dk_debugFunc 2 3
    
    set "_haystack_=%~1"
    set "_needle_=%~2"
	
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
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
    %dk_call% dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_includes "%string%" "%substring%" result
    if %result% equ 0 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_includes "%string%" "%substring%" result
    if %result% equ 0 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_includes "%string%" "%substring%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_includes "%string%" "%substring%"
    if not ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "needle"
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")

    %dk_call% dk_echo
    %dk_call% dk_set string "There is a needle in this haystack"
    %dk_call% dk_set substring "straw"
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    ::FIXME: ERRORLEVEL is still 1
	
	::###### Using && and || conditionals
    %dk_call% dk_echo
	echo dk_includes "There is a needle in this haystack" "needle"
    %dk_call% dk_includes "There is a needle in this haystack" "needle" && (%dk_call% dk_echo "There is a needle in this haystack' CONTAINS 'needle'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'needle'")

    %dk_call% dk_echo
	echo dk_includes "There is a needle in this haystack" "straw"
    %dk_call% dk_includes "There is a needle in this haystack" "straw" && (%dk_call% dk_echo "'There is a needle in this haystack' CONTAINS 'straw'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'straw'")
    ::FIXME: ERRORLEVEL is still 1
%endfunction%
