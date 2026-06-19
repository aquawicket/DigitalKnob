rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT EXIST "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\DK.cmd" (for /F "tokens=*" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\DK.cmd" (
		"%SystemRoot%\System32\curl.exe" --silent --location --create-dirs --output "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\DK.cmd" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\DK.cmd" "%~0" %*
	exit /b %errorlevel%

