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


::setlocal EnableExtensions
::setlocal DisableExtensions


if "~x0" equ "%~x0" goto :NOCMDEXT
if "%%~x0" equ "%~x0" goto :NOCMDEXT
if CmdExtVersion 2 goto :CMDEXTV2
goto :CMDEXTV1
pause

:CMDEXTV1
echo Command extensions v1 available
pause
goto :EOF

:CMDEXTV2
echo Command extensions v2 or later available
pause
exit /b 0

:NOCMDEXT
echo Command extensions NOT available
pause
rem END OF FILE

