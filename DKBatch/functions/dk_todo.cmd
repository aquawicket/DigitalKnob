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
rem # dk_todo(message)
rem #
rem #    Print a todo message to the console
rem #
rem #    @message - The message to print
rem #
:dk_todo
%setlocal%
	
	rem ### SETTINGS ###
	if NOT defined dk_log_TODO_ENABLE			(set "dk_log_TODO_ENABLE=1")
	if NOT defined dk_log_TODO_COLOR			(set "dk_log_TODO_COLOR=%blue%")
	if NOT defined dk_log_TODO_TAG				(set "dk_log_TODO_TAG=TODO: ")
	rem if NOT defined dk_log_TODO_TRACE		(set "dk_log_TODO_TRACE=0")
	rem if NOT defined dk_log_TODO_LINE			(set "dk_log_TODO_LINE=0")
	rem if NOT defined dk_log_TODO_SOUND		(set "dk_log_TODO_SOUND=0")
	rem if NOT defined dk_log_TODO_TIMEOUT		(set "dk_log_TODO_TIMEOUT=10")
	rem if NOT defined dk_log_TODO_PAUSE		(set "dk_log_TODO_PAUSE=0")
	rem if NOT defined dk_log_TODO_HALT			(set "dk_log_TODO_HALT=0")

	if "%~1" equ "" (echo. & exit /b 0)  
    %dk_call% dk_log TODO "%~1"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
    %dk_call% dk_todo "test dk_todo message"
%endfunction%
