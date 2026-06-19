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
rem # dk_minMaxArgs(min, max)
rem #
:dk_minMaxArgs
%setlocal%
    rem echo "%__FUNCTION__%(%__ARGS__%)"
    if %__ARGC__% lss %~1 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): NOT enough arguments. Minimum is %~1, got %__ARGC__%"
    if "%~2" equ "" if %__ARGC__% gtr %~1 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~1, got %__ARGC__%"
    if "%~2" neq "" if %__ARGC__% gtr %~2 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~2, got %__ARGC__%"
%endfunction%
