@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################




rem ##################################################################################
rem # dk_debug(<message>)
rem #
rem #    Print a debug message to the console
rem #
rem #    @message - The message to print
rem #
:dk_debug
	if NOT DEFINED dk_log_LEVELS 							(set "dk_log_LEVELS=DEBUG")
	if "x%dk_log_LEVELS:DEBUG=%x" equ "x%dk_log_LEVELS%x" 	(set "dk_log_LEVELS=%dk_log_LEVELS%;DEBUG")
	if NOT defined dk_log_DEBUG_ENABLE						(set "dk_log_DEBUG_ENABLE=1")
	if NOT defined dk_log_DEBUG_COLOR						(set "dk_log_DEBUG_COLOR=%lblue%")
	if NOT defined dk_log_DEBUG_TAG							(set "dk_log_DEBUG_TAG=DEBUG: ")
	rem if NOT defined dk_log_DEBUG_TRACE					(set "dk_log_DEBUG_TRACE=0")
	rem if NOT defined dk_log_DEBUG_LINE					(set "dk_log_DEBUG_LINE=0")
	rem if NOT defined dk_log_DEBUG_SOUND					(set "dk_log_DEBUG_SOUND=0")
	rem if NOT defined dk_log_DEBUG_TIMEOUT					(set "dk_log_DEBUG_TIMEOUT=0")
	rem if NOT defined dk_log_DEBUG_PAUSE					(set "dk_log_DEBUG_PAUSE=0")
	rem if NOT defined dk_log_DEBUG_HALT					(set "dk_log_DEBUG_HALT=0")
%setlocal%
		
	
	if "%~1" equ "" (echo. & exit /b 0)  
	%dk_call% dk_log DEBUG %*
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
!setlocal!

    %dk_call% dk_debug "test dk_debug message"
	%dk_call% dk_debug test dk_debug message
%endfunction%
