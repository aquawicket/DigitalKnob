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
rem # dk_getFileTime(path rtn_var)
rem #
rem #
:dk_getFileTime
%setlocal%

	set _input=%1
	set _input=%_input:"=%
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	endlocal & for %%Z in ("%_input%") do set "%2=%%~tZ"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getFileTime "%myPath%" fileTime
	%dk_call% dk_printVar fileTime
%endfunction%
