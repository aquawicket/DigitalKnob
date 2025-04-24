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
::# dk_timeoutCall(command, seconds)
::#
::#    Call a command after timeout
::#
:dk_timeoutCall
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal

=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

	
>>>>>>> Development
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
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
=======
setlocal
	%dk_call% dk_debugFunc 0
   
>>>>>>> Development
    %dk_call% dk_timeoutCall "ver" 3

%endfunction%
