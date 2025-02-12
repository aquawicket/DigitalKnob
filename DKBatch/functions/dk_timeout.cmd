@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::##################################################################################
::# dk_timeout(seconds)
::#
::#    Pause execution and wait for <enter> keypress to continue or until <n> amount of seconds have passed
::#
:dk_timeout
setlocal
    ::%dk_call% dk_debugFunc 0 1
    
	if "%~1" equ "" (set "timeout_seconds=10") else (set "timeout_seconds=%~1")
	
	if not defined timeout_seconds (%dk_call% dk_error "timeout_seconds is invalid")
	
    (timeout /t %timeout_seconds%)
	(call )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
%endfunction%
