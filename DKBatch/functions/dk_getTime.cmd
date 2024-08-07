@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getTime(centisecond second minute hour)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getTime
	call dk_debugFunc
	call dk_minMaxArgs 4
	
	setlocal
	for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c"
	for /f "tokens=1-4 delims=%delims%" %%G in ("%time%") do (
		set _hour=%%G
		set _minute=%%H
		set _second=%%I
		set _centisecond=%%J
	)
	:: Strip any leading spaces
	set _hour=%_hour: =%
	:: Ensure the hours have a leading zero
	if 1%_hour% lss 20 set _hour=0%_hour%
	endlocal & set "%1=%_centisecond%" & set "%2=%_second%" & set "%3=%_minute%" & set "%4=%_hour%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	echo time = %time%
	call dk_getTime centisecond second minute hour
	echo time = %hour%:%minute%:%second%.%centisecond%
goto:eof	