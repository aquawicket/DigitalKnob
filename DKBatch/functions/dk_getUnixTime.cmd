@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getUnixTime(<ret>:OPTIONAL)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getUnixTime
%setlocal%
	%dk_call% dk_debugFunc 0 1
    for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do (set %%x)
    set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
    set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
    set /a dk_getUnixTime=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
    endlocal & (
		set "dk_getUnixTime=%dk_getUnixTime%"
		if "%~1" neq "" (set "%~1=%dk_getUnixTime%")
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getUnixTime
    %dk_call% dk_printVar dk_getUnixTime
%endfunction%
