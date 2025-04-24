<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_appendArgs(variable, string)
::#
::#
:dk_appendArgs
<<<<<<< HEAD
    call dk_debugFunc 2 99
 setlocal
 
    for /f "tokens=1,* delims= " %%a in ("%*") do set "ALL_BUT_FIRST=%%b"

    if defined %~1 endlocal & call set "%~1=%%%~1%% %ALL_BUT_FIRST%"
    if not defined %~1 endlocal & set "%~1=%ALL_BUT_FIRST%
	
%DEBUG%
	%dk_call% dk_printVar %1
=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 99

	%dk_call% dk_allButFirstArgs %*

	endlocal & (
		if defined %~1 (
			set "%~1=!%~1! %dk_allButFirstArgs%"
		) else (
			set "%~1=%dk_allButFirstArgs%"
		)
	)
>>>>>>> Development
%endfunction%





<<<<<<< HEAD
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_appendArgs myVar 123 abc
    %dk_call% dk_debug "myVar = %myVar%"

    %dk_call% dk_appendArgs myVar 456 zyx
    %dk_call% dk_debug "myVar = %myVar%"
=======






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_appendArgs myVar 123 abc
	%dk_call% dk_echo "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 456 def
	%dk_call% dk_echo "myVar = %myVar%"

	%dk_call% dk_appendArgs myVar 789 ghi
	%dk_call% dk_echo "myVar = %myVar%"
>>>>>>> Development
%endfunction%
