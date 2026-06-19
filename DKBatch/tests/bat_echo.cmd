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


if "%~1" neq "" goto %~1

:main
	echo this is a string echoed from bat_echo
%endfunction%

:hour
	set hour=%time:~0,2%
	if "%hour:~0,1%" equ " " set hour=0%hour:~1,1%
	echo %hour%
%endfunction%

:minute
	set minute=%time:~3,2%
	if "%minute:~0,1%" equ " " set minute=0%minute:~1,1%
	echo %minute%
%endfunction%

:second
	set second=%time:~6,2%
	if "%second:~0,1%" equ " " set second=0%second:~1,1%
	echo %second%
%endfunction%

:millisecond
	set millisecond=%time:~9,2%
	if "%millisecond:~0,1%" equ " " set millisecond=0%millisecond:~1,1%
	echo %millisecond%
%endfunction%