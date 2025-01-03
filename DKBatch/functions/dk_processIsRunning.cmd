@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_processIsRunning(name, result)
::#
::#
:dk_processIsRunning
setlocal
	%dk_call% dk_debugFunc 2

    tasklist | find /i "%1" > nul
    if "%ERRORLEVEL%"=="0" endlocal & set "%2=1" && %return%
    endlocal & set "%2=0"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_processIsRunning cmd cmdIsRunning
	%dk_call% dk_echo "cmdIsRunning = %cmdIsRunning%"
	
	%dk_call% dk_processIsRunning nonExisent nonExisentIsRunning
	%dk_call% dk_echo "nonExisentIsRunning = %nonExisentIsRunning%"
%endfunction%
