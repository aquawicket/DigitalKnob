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
rem # dk_success(message)
rem #
rem #    Print a warning message to the console
rem #
rem #    @message - The message to print
rem #
:dk_success
%setlocal%
	
	rem ###### dk_success() Settings ######
	if NOT defined dk_log_SUCCESS_ENABLE		(set "dk_log_SUCCESS_ENABLE=1")
	if NOT defined dk_log_SUCCESS_COLOR			(set "dk_log_SUCCESS_COLOR=%green%")
	if NOT defined dk_log_SUCCESS_TAG			(set "dk_log_SUCCESS_TAG=SUCCESS: ")
	rem if NOT defined dk_log_SUCCESS_TRACE		(set "dk_log_SUCCESS_TRACE=0")
	rem if NOT defined dk_log_SUCCESS_LINE		(set "dk_log_SUCCESS_LINE=0")
	rem if NOT defined dk_log_SUCCESS_SOUND		(set "dk_log_SUCCESS_SOUND=0")
	rem if NOT defined dk_log_SUCCESS_TIMEOUT		(set "dk_log_SUCCESS_TIMEOUT=0")
	rem if NOT defined dk_log_SUCCESS_PAUSE		(set "dk_log_SUCCESS_PAUSE=0")
	rem if NOT defined dk_log_SUCCESS_HALT		(set "dk_log_SUCCESS_HALT=0")
	rem ###################################
	
	if "%~1" equ "" (echo. & exit /b 0)
	rem %dk_call% dk_log SUCCESS "%~1"
	rem if [%*] equ [] (echo. & exit /b 0) 
	%dk_call% dk_log SUCCESS %*
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_success "test dk_success message"
	%dk_call% dk_success test dk_success message
%endfunction%
