@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_timeout(seconds)
::#
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
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_timeout 1
	%dk_call% dk_timeout 5
	%dk_call% dk_timeout
	%dk_call% dk_timeout 3
%endfunction%
