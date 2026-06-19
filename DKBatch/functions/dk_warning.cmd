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
rem # dk_warning(message)
rem #
rem #    Print a warning message to the console
rem #
rem #    @message - The message to print
rem #
:dk_warning
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=WARNING")
	if "x%dk_log_LEVELS:WARNING=%x" equ "x%dk_log_LEVELS%x" (set "dk_log_LEVELS=%dk_log_LEVELS%;WARNING")
	if NOT defined dk_log_WARNING_ENABLE					(set "dk_log_WARNING_ENABLE=1")
	if NOT defined dk_log_WARNING_COLOR						(set "dk_log_WARNING_COLOR=%yellow%")
	if NOT defined dk_log_WARNING_TAG						(set "dk_log_WARNING_TAG=WARNING: ")
	if NOT defined dk_log_WARNING_TRACE						(set "dk_log_WARNING_TRACE=1")
	rem if NOT defined dk_log_WARNING_LINE					(set "dk_log_WARNING_LINE=0")
	rem if NOT defined dk_log_WARNING_SOUND					(set "dk_log_WARNING_SOUND=0")
	rem if NOT defined dk_log_WARNING_TIMEOUT				(set "dk_log_WARNING_TIMEOUT=0")
	rem if NOT defined dk_log_WARNING_PAUSE					(set "dk_log_WARNING_PAUSE=0")
	rem if NOT defined dk_log_WARNING_HALT					(set "dk_log_WARNING_HALT=0")
%setlocal%
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log WARNING %*
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_warning "test dk_warning message"
%endfunction%
