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


rem https://stackoverflow.com/a/61752820/688352
echo Press Y to break
call:function

NEVER REACHED
exit /b %errorlevel%

:function
    echo Loop in progress...
    choice /C ny /T 1 /D n /N>x
    <x 1>nul 2>nul call :checkify
goto:function


rem When a batch file is interrupted via Ctrl-C, AKA STATUS_CONTROL_C_EXIT, it returns ErrorLevel -1073741510 or ExitCode C000013A. We can take advantage of this.
:checkify
%ComSpec% /c exit -1073741510