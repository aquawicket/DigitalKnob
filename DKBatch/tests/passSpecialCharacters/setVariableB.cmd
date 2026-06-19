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


:setVariableB name value
::setlocal
	echo "setVariable_B %~1 '%~2'"

	set "temp=%~2"
	set "temp=%temp:^^=^%"
	set "%~1=%temp%"
	

	call echo setVariable OUTPUT: %~1 = "%%%~1%%"
setlocal enableDelayedExpansion
	
	echo setVariable_B OUTPUT: %~1 = '!%~1!'
%endfunction%
