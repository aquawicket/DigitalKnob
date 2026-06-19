rem shebang
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


::############ windows_terminal ############
::# https://github.com/microsoft/terminal
::# https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_arm64.zip
::# https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x86.zip
::# https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x64.zip

:DKINSTALL
::%setlocal%
	
	if EXIST "%wt_exe%" (%return%)
	
	%dk_call% dk_import
	
	set "wt_exe=%windows_terminal%/wt.exe"
	
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
%endfunction%

