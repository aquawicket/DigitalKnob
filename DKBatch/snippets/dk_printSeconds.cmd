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


rem #########################################################################################################
::# dk_printSeconds()
::#
::#
:dk_printSeconds
::setlocal
	
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




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	
	call dk_printSeconds
%endfunction%
