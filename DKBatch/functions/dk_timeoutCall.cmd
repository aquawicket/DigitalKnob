@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_timeoutCall(command, seconds)
::#
::#    Call a command after timeout
::#
:dk_timeoutCall
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

	
	for /F %%# in ('copy /Z "%~dpf0" NUL') do set "CR=%%#"
	
	:Timer
    for /L %%i in (%~2 -1 1) do (
		<nul set /p ".= calling '%~1' in  %%i  Seconds [R]estart Timer [C]ancel [N]o wait !CR!"
        for /F "Delims=" %%G in ('choice /T 1 /N /C:CRNW /D W') do (
            if %%G==R goto Timer
            if %%G==C goto Cancel
            if %%G==N goto NoWait
        )
    )
	
	:NoWait
	<nul set /p ".=.                                                                     !CR!"
	endlocal & %~1
	exit /b 0
	
	:Cancel
	<nul set /p ".=.                                                                     !CR!"
	exit /b 0
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_timeoutCall "ver" 3

%endfunction%
