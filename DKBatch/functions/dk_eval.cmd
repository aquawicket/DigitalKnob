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

if NOT defined dk_eval_DEBUG (set "dk_eval_DEBUG=1")
rem ############################################################################
rem # dk_eval()
rem #
rem #
:dk_eval
%setlocal%

	set "code=%*"
	
	if "%dk_eval_DEBUG%" equ "1" (
		%dk_call% dk_echo "%lblue%dk_eval> %lcyan%%code%%clr%"
	)
	
	%dk_call% dk_exec %code%
	endlocal & (
		set "dk_eval=%dk_exec%"
	)
	
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% dk_eval ver
	%dk_call% dk_debug "dk_eval = %dk_eval%"
%endfunction%

