<<<<<<< HEAD
@if (@X) == (@Y) @end /*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::##################################################################################
::# dk_timeout(seconds)
::#
<<<<<<< HEAD
::#    Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
::#
:dk_timeout
 setlocal
    call dk_debugFunc 0 1
    
	::if "%~1" equ "" (set "pause_msg=Press any key to continue...") else (set "pause_msg=%~1")
    ::if "%~1" neq " " %dk_call% dk_echo "%pause_msg%"
	if "%~1" equ "" (set "timeout_seconds=10") else (set "timeout_seconds=%~1")
    timeout /t %timeout_seconds%
=======
::#    Pause execution and wait for <enter> keypress or until <n> amount of seconds have passed to continue 
::#
:dk_timeout
setlocal
    %dk_call% dk_debugFunc 0 1
    
	if "%~1" equ "" (set "seconds=10") else (set "seconds=%~1")
	%dk_call% dk_assertVar seconds
	
	%dk_call% dk_validate TIMEOUT_EXE "%dk_call% dk_TIMEOUT_EXE"
	%TIMEOUT_EXE% %seconds%
	
	
	endlocal & set "TIMEOUT_EXE=%TIMEOUT_EXE%"
	(call )
>>>>>>> Development
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
=======
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
	%dk_call% dk_timeout 3
>>>>>>> Development
%endfunction%
