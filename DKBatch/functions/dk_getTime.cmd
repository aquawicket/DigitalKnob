@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

:dk_getTime
	setlocal
	for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c"
	for /f "tokens=1-4 delims=%delims%" %%G in ("%time%") do (
		set _hh=%%G
		set _min=%%H
		set _ss=%%I
		set _ms=%%J
	)
	:: Strip any leading spaces
	set _hh=%_hh: =%
	:: Ensure the hours have a leading zero
	if 1%_hh% lss 20 set _hh=0%_hh%
	endlocal & set %1=%_hh%:%_min%:%_ss%.%_ms%
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	call dk_getTime myTime
	call dk_printVar myTime
goto:eof	