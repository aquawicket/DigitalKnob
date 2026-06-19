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
rem # dk_printLastError()
rem #
:dk_printLastError

	if "%LAST_STATUS%" equ "0"	echo %LAST_FUNC%(%LAST_ARGV%): %green%%LAST_STATUS% '%LAST_MESSAGE%' %clr%
	if "%LAST_STATUS%" neq "0"	echo %LAST_FUNC%(%LAST_ARGV%): %red%%LAST_STATUS% '%LAST_MESSAGE%' %clr%
	rem if "%LAST_STATUS%" neq "0" call dk_error "%LAST_FUNC%(%LAST_ARGV%): %LAST_STATUS% '%LAST_MESSAGE%' %clr%"

rem call exit /b %LAST_STATUS%