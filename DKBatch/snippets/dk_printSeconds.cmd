@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#########################################################################################################
::# dk_printSeconds()
::#
::#
:dk_printSeconds
	call dk_debugFunc 0
	
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
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_printSeconds
goto:eof