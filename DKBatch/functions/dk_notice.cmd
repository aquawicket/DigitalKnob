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
rem # dk_notice(message)
rem #
rem #    Print a notice message to the console
rem #
rem #    @message - The message to print
rem #
:dk_notice
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=NOTICE")
	if "x%dk_log_LEVELS:NOTICE=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;NOTICE")
	if NOT defined dk_log_NOTICE_ENABLE						(set "dk_log_NOTICE_ENABLE=1")
	if NOT defined dk_log_NOTICE_COLOR						(set "dk_log_NOTICE_COLOR=%lyellow%")
	if NOT defined dk_log_NOTICE_TAG						(set "dk_log_NOTICE_TAG=NOTICE: ")
	rem if NOT defined dk_log_NOTICE_TRACE					(set "dk_log_NOTICE_TRACE=0")
	rem if NOT defined dk_log_NOTICE_LINE					(set "dk_log_NOTICE_LINE=0")
	rem if NOT defined dk_log_NOTICE_SOUND					(set "dk_log_NOTICE_SOUND=0")
	rem if NOT defined dk_log_NOTICE_TIMEOUT				(set "dk_log_NOTICE_TIMEOUT=0")
	rem if NOT defined dk_log_NOTICE_PAUSE					(set "dk_log_NOTICE_PAUSE=0")
	rem if NOT defined dk_log_NOTICE_HALT					(set "dk_log_NOTICE_HALT=0")
%setlocal%
    if "%~1" equ "" (echo. & exit /b 0) 
    %dk_call% dk_log NOTICE "%~1"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_notice "test dk_notice message"
%endfunction%
