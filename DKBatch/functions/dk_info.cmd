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
rem # dk_info(message)
rem #
rem #    Print a info message to the console
rem #
rem #    @message - The message to print
rem #
:dk_info
%setlocal%
	
	rem ### SETTINGS ###
	if NOT defined dk_log_INFO_ENABLE			(set "dk_log_INFO_ENABLE=1")
	if NOT defined dk_log_INFO_COLOR			(set "dk_log_INFO_COLOR=%white%")
	if NOT defined dk_log_INFO_TAG				(set "dk_log_INFO_TAG=INFO: ")
	rem if NOT defined dk_log_INFO_TRACE			(set "dk_log_INFO_TRACE=0")
	rem if NOT defined dk_log_INFO_LINE			(set "dk_log_INFO_LINE=0")
	rem if NOT defined dk_log_INFO_SOUND			(set "dk_log_INFO_SOUND=0")
	rem if NOT defined dk_log_INFO_TIMEOUT		(set "dk_log_INFO_TIMEOUT=0")
	rem if NOT defined dk_log_INFO_PAUSE			(set "dk_log_INFO_PAUSE=0")
	rem if NOT defined dk_log_INFO_HALT			(set "dk_log_INFO_HALT=0")

	if "%~1" equ "" (echo. & exit /b 0)  
    %dk_call% dk_log INFO "%~1"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_info "test string from dk_info"
%endfunction%
