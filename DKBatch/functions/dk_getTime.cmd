@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getTime(centisecond second minute hour)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getTime
setlocal
	%dk_call% dk_debugFunc 4
    for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c" 
    for /f "tokens=1-4 delims=%delims%" %%A in ("%time%") do (
        set "_hour=%%A"
        set "_minute=%%B"
        set "_second=%%C"
        set "_centisecond=%%D"
    )
    :: Strip any leading spaces
    set "_hour=%_hour: =%"
    :: Ensure the hours have a leading zero
    if 1%_hour% lss 20 set "_hour=0%_hour%"
    
	endlocal & (
		set "%~1=%_centisecond%"
		set "%~2=%_second%"
		set "%~3=%_minute%"
		set "%~4=%_hour%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    echo time = %time%
    %dk_call% dk_getTime centisecond second minute hour
    echo time = %hour%:%minute%:%second%.%centisecond%
	%dk_call% dk_getTime centisecond second minute hour
    echo time = %hour%:%minute%:%second%.%centisecond%
	%dk_call% dk_getTime centisecond second minute hour
    echo time = %hour%:%minute%:%second%.%centisecond%
	%dk_call% dk_getTime centisecond second minute hour
    echo time = %hour%:%minute%:%second%.%centisecond%
%endfunction%   
