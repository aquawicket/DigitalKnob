@if (@X) == (@Y) @end /*
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


rem ##################################################################################
rem # dk_pause(pause_msg)
rem #
rem #    Pause execution and wait for <enter> keypress to continue
rem #
:dk_pause
%setlocal%
   
    if "%~1" equ "" (set "pause_msg=Press any key to continue...") else (set "pause_msg=%~1")
    if "%~1" neq " " %dk_call% dk_echo "%pause_msg%"
    pause >nul
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	%dk_call% dk_echo  "Pause with default message"
    %dk_call% dk_pause
    %dk_call% dk_pause "Pause with a custom message"
    %dk_call% dk_pause "%red%Pause %green%with %blue%colorful %yellow%message%clr%"
    %dk_call% dk_echo  "Pause with no message"
    %dk_call% dk_pause " "
%endfunction%
