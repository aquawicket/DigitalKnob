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


rem ####################################################################
rem # dk_driveName(<pathname>, <output>:optional)
rem #
rem #
:dk_driveName
%setlocal%

	set "pathname=%1"
	set "pathname=%pathname:"=%"
	
rem if "%pathname:~-1%" equ "\" (set "pathname=%pathname:~0,-1%")
rem if "%pathname:~-1%" equ "/" (set "pathname=%pathname:~0,-1%")
	for %%Z in ("%pathname%") do set "dk_driveName=%%~dZ"
	
	:return
	endlocal & (
		set "dk_driveName=%dk_driveName%"
		if "%~2" neq "" (set "%~2=%dk_driveName%")
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_set myPath "C:/Windows"
	%dk_call% dk_driveName "%myPath%" drive
	%dk_call% dk_printVar drive
	
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_driveName "%myPath%" drive
	%dk_call% dk_printVar drive
%endfunction%
