@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# dk_processIsRunning(name, result)
::#
::#
:dk_processIsRunning
setlocal
	%dk_call% dk_debugFunc 2

    tasklist | find /i "%1" > nul
    if "%ERRORLEVEL%" equ "0" (
		set "dk_processIsRunning=0"
	) else (
		set "dk_processIsRunning=1"
	)
	
	endlocal & (
		set "dk_processIsRunning=%dk_processIsRunning%"
		if "%~2" neq "" (set "%~2=%dk_processIsRunning%")
	)
	
	exit /b %dk_processIsRunning%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "process=cmd"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running

	set "process=nonExisent"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running
%endfunction%
