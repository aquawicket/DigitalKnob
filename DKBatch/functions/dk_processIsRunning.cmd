@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_processIsRunning(name, result)
::#
::#
:dk_processIsRunning
    call dk_debugFunc 2
 setlocal
 
    tasklist | find /i "%1" > nul
    if "%ERRORLEVEL%"=="0" endlocal & set "%2=1" && %return%
    endlocal & set "%2=0"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_processIsRunning cmd cmdIsRunning
	%dk_call% dk_echo "cmdIsRunning = %cmdIsRunning%"
	
	%dk_call% dk_processIsRunning nonExisent nonExisentIsRunning
	%dk_call% dk_echo "nonExisentIsRunning = %nonExisentIsRunning%"
%endfunction%
