@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_processIsRunning(name, result)
::#
::#
:dk_processIsRunning
%setlocal%
	%dk_call% dk_debugFunc 2

    tasklist | find /i "%~1" > nul
	set "dk_processIsRunning=%ERRORLEVEL%"

	endlocal & (
		set "dk_processIsRunning=%dk_processIsRunning%"
		if "%~2" neq "" (set "%~2=%dk_processIsRunning%")
	)
	
	exit /b %dk_processIsRunning%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "process=cmd.exe"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running

	set "process=nonExisent"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running
	
	set "process=cmake-gui.exe"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running
%endfunction%
