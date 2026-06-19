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
rem # dk_fatal(message)
rem #
rem #    Print a error message to the console
rem #
rem #    @message - The message to print
rem #
:dk_fatal
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=FATAL")
	if "x%dk_log_LEVELS:FATAL=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;FATAL")
	if NOT defined dk_log_FATAL_ENABLE						(set "dk_log_FATAL_ENABLE=1")
	if NOT defined dk_log_FATAL_COLOR						(set "dk_log_FATAL_COLOR=%red%")
	if NOT defined dk_log_FATAL_TAG							(set "dk_log_FATAL_TAG=FATAL: ")
	if NOT defined dk_log_FATAL_TRACE						(set "dk_log_FATAL_TRACE=1")
	rem if NOT defined dk_log_FATAL_LINE					(set "dk_log_FATAL_LINE=0")
	rem if NOT defined dk_log_FATAL_SOUND					(set "dk_log_FATAL_SOUND=0")
	rem if NOT defined dk_log_FATAL_TIMEOUT					(set "dk_log_FATAL_TIMEOUT=10")
	if NOT defined dk_log_FATAL_PAUSE						(set "dk_log_FATAL_PAUSE=1")
	rem if NOT defined dk_log_FATAL_HALT					(set "dk_log_FATAL_HALT=0")
%setlocal%
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log FATAL %* 1>&2
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo "test dk_echo message"
	%dk_call% dk_sleep 1
	%dk_call% dk_echo "test dk_echo message"
    %dk_call% dk_fatal "test dk_fatal message"
	%dk_call% dk_echo "test dk_echo message"
%endfunction%
