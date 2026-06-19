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
rem # dk_echoReplace(message)
rem #
rem #     Print a message to the console
rem #
rem #     @msg    - The message to print
rem #
:dk_echoReplace
%setlocal%

    if "%~1" equ "" (%return%)  
    set "_message_=%~1"
       
	rem if NOT defined CR  (for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a")
	for /f %%a in ('copy /Z "%~dpf0" nul') do (set "CR=%%a")

	%dk_call% dk_consoleColumns
	%dk_call% dk_strlen _message_
	set /a "endlen=dk_consoleColumns-dk_strlen-2"
	set "endspace= "
	for /l %%n in (0,1,%endlen%) do (set "endspace=!endspace! ")
rem         The last dk_echoReplace line loses it's first character
	set /P "=%_message_%%endspace%!CR!" <nul
	%clearerror%
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    echo.This is a normal echo commmand
    %dk_call% dk_echoReplace
    %dk_call% dk_echoReplace ""
    %dk_call% dk_echoReplace "This is a dk_echoReplace line"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "Another dk_echoReplace line"
	%dk_call% dk_sleep 1
	echo.This is a normal echo commmand
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "and another dk_echoReplace line"
	%dk_call% dk_sleep 1
    rem %dk_call% dk_echoReplace """This is a dk_echoReplace line with quotes"""
	rem %dk_call% dk_sleep 1
    %dk_call% dk_echoReplace "This is %red%dk_echoReplace %blue%with color%clr%"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "We will replace many many characters that go almost all the way over to the end of the console"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "x"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "We will replace many many characters that go almost all the way over to the end of the console but maybe even further all the way past the end of the entire console and on and on and on still going until we know for sure we have written past the number of console columns, and ...   there, that should do it."
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "x"
	%dk_call% dk_sleep 3
%endfunction%
