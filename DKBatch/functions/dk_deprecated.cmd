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
rem # dk_deprecated(message)
rem #
rem #    Print a deprecated message to the console
rem #
rem #    @message - The message to print
rem #
:dk_deprecated
	if NOT DEFINED dk_log_LEVELS 								(set "dk_log_LEVELS=DEPRECATED")
	if "x%dk_log_LEVELS:DEPRECATED=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;DEPRECATED")
	if NOT defined dk_log_DEPRECATED_ENABLE						(set "dk_log_DEPRECATED_ENABLE=1")
	if NOT defined dk_log_DEPRECATED_COLOR						(set "dk_log_DEPRECATED_COLOR=%dim%%yellow%")
	if NOT defined dk_log_DEPRECATED_TAG						(set "dk_log_DEPRECATED_TAG=DEPRECATED: ")
	if NOT defined dk_log_DEPRECATED_TRACE						(set "dk_log_DEPRECATED_TRACE=1")
	rem if NOT defined dk_log_DEPRECATED_LINE					(set "dk_log_DEPRECATED_LINE=0")
	rem if NOT defined dk_log_DEPRECATED_SOUND					(set "dk_log_DEPRECATED_SOUND=0")
	if NOT defined dk_log_DEPRECATED_TIMEOUT					(set "dk_log_DEPRECATED_TIMEOUT=3")
	rem if NOT defined dk_log_DEPRECATED_PAUSE					(set "dk_log_DEPRECATED_PAUSE=0")
	rem if NOT defined dk_log_DEPRECATED_HALT					(set "dk_log_DEPRECATED_HALT=0")
%setlocal%
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log DEPRECATED %*
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_deprecated "test dk_deprecated message"
%endfunction%
