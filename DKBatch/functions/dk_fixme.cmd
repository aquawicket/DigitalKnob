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
rem # dk_fixme(message)
rem #
rem #    Print a fixme message to the console
rem #
rem #    @message - The message to print
rem #
:dk_fixme
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=FIXME")
	if "x%dk_log_LEVELS:FIXME=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;FIXME")
	if NOT defined dk_log_FIXME_ENABLE						(set "dk_log_FIXME_ENABLE=1")
	if NOT defined dk_log_FIXME_COLOR						(set "dk_log_FIXME_COLOR=%lyellow%")
	if NOT defined dk_log_FIXME_TAG							(set "dk_log_FIXME_TAG=FIXME: ")
	rem if NOT defined dk_log_FIXME_TRACE					(set "dk_log_FIXME_TRACE=0")
	rem if NOT defined dk_log_FIXME_LINE					(set "dk_log_FIXME_LINE=0")
	rem if NOT defined dk_log_FIXME_SOUND					(set "dk_log_FIXME_SOUND=0")
	rem if NOT defined dk_log_FIXME_TIMEOUT					(set "dk_log_FIXME_TIMEOUT=3")
	rem if NOT defined dk_log_FIXME_PAUSE					(set "dk_log_FIXME_PAUSE=0")
	rem if NOT defined dk_log_FIXME_HALT					(set "dk_log_FIXME_HALT=0")
%setlocal%
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log FIXME %*
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_fixme "test dk_fixme message"
%endfunction%
