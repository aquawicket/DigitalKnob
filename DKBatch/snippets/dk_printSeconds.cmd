<<<<<<< HEAD
@echo off
if not defined DKINIT if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::#########################################################################################################
::# dk_printSeconds()
::#
::#
:dk_printSeconds
<<<<<<< HEAD
	call dk_debugFunc 0
=======
::setlocal
	%dk_call% dk_debugFunc 0
>>>>>>> Development
	
	for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c" 
	for /f "tokens=1-4 delims=%delims%" %%A in ("%time%") do (set /a "hour=%%A" & set /a "minute=%%B" & set /a "second=%%C" & set /a "centisecond=%%D")
	
	
	echo %hour%:%minute%:%second%.%centisecond%
	
	set /a "centisecond=100%centisecond%%%100"
	set /a "second=100%second%%%100"
	set /a "minute=100%minute%%%100"
	set /a "hour=100%hour%%%100"
	echo %hour%:%minute%:%second%.%centisecond%
	
	
	set /a "minutes_in_seconds=%minute%*60+%second%"
	set /a "hours_in_seconds=%hour%*60*60+%minutes_in_seconds%"
	set "total_seconds=%hours_in_seconds%"

	echo %total_seconds%.%centisecond%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
	call dk_debugFunc 0
=======
setlocal
	%dk_call% dk_debugFunc 0
>>>>>>> Development
	
	call dk_printSeconds
%endfunction%
