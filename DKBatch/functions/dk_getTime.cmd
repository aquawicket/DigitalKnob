@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_getTime(centisecond second minute hour)
rem #
rem #    REFERENCE: https://ss64.com/nt/syntax-gettime.html
rem #
:dk_getTime
%setlocal%
    for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c"
    for /f "tokens=1-4 delims=%delims%" %%A in ("%time%") do (
        set "_hour=%%A"
        set "_minute=%%B"
        set "_second=%%C"
        set "_centisecond=%%D"
    )
    rem Strip any leading spaces
    set "_hour=%_hour: =%"
    rem Ensure the hours have a leading zero
    if 1%_hour% lss 20 set "_hour=0%_hour%"
   
	endlocal & (
		set "%~1=%_centisecond%"
		set "%~2=%_second%"
		set "%~3=%_minute%"
		set "%~4=%_hour%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

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
