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
rem # dk_error(message)
rem #
rem #    Print a error message to the console
rem #
rem #    @message - The message to print
rem #
:dk_error
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=ERROR")
	if "x%dk_log_LEVELS:ERROR=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;ERROR")
	if NOT defined dk_log_ERROR_ENABLE						(set "dk_log_ERROR_ENABLE=1")
	if NOT defined dk_log_ERROR_COLOR						(set "dk_log_ERROR_COLOR=%lred%")
	if NOT defined dk_log_ERROR_TAG							(set "dk_log_ERROR_TAG=ERROR: ")
	if NOT defined dk_log_ERROR_TRACE						(set "dk_log_ERROR_TRACE=1")
	rem if NOT defined dk_log_ERROR_LINE					(set "dk_log_ERROR_LINE=0")
	rem if NOT defined dk_log_ERROR_SOUND					(set "dk_log_ERROR_SOUND=0")
	rem if NOT defined dk_log_ERROR_TIMEOUT					(set "dk_log_ERROR_TIMEOUT=3")
	if NOT defined dk_log_ERROR_PAUSE						(set "dk_log_ERROR_PAUSE=1")
	rem if NOT defined dk_log_ERROR_HALT					(set "dk_log_ERROR_HALT=0")
	rem if NOT defined dk_log_ERROR_CALLBACK				(set "dk_log_ERROR_CALLBACK=0")
%setlocal%
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log ERROR %* 1>&2
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_error "test dk_error message"
%endfunction%
