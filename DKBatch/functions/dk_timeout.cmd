@if (@X) == (@Y) @end /*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_timeout(seconds)
::#
::#    Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
::#
:dk_timeout
 setlocal
    call dk_debugFunc 0 1
    
	::if "%~1" equ "" (set "pause_msg=Press any key to continue...") else (set "pause_msg=%~1")
    ::if "%~1" neq " " %dk_call% dk_echo "%pause_msg%"
	if "%~1" equ "" (set "timeout_seconds=10") else (set "timeout_seconds=%~1")
    timeout /t %timeout_seconds%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
%endfunction%
