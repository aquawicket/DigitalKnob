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
rem # dk_echoNNL(message)
rem #
rem #     Print a message to the console without a new line
rem #
rem #     @msg    - The message to print
rem #
:dk_echoNNL
%setlocal%

	if "%~1" equ "" (goto:eof)
	set "_message_=%~1"

	rem if msg starts and ends with quotes, remove the first and last characters
	rem %if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
	rem %if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"

	set /P "=%_message_%" <nul
exit /b 0
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.This is a normal echo commmand
	%dk_call% dk_echoNNL "No "
	%dk_call% dk_echoNNL "new "
	%dk_call% dk_echoNNL "line "
	%dk_call% dk_echoNNL "will "
	%dk_call% dk_echoNNL "be "
	%dk_call% dk_echoNNL "printed "
%endfunction%
