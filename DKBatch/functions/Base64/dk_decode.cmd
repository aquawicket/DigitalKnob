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
rem # Base64::dk_decode(inputFile)
rem # Base64::dk_decode(inputFile, outputFile)
rem #
rem #	Decode base-64 input to output
rem #	https://github.com/base64code/examples
rem #
:dk_decode
%setlocal%

	set "inputFile=%~1"
	%dk_call% dk_removeExtension %inputFile% outputFile
	if "%~2" neq "" set "outputFile=%~2"

	if NOT EXIST "%inputFile%" %dk_call% dk_error "%inputFile% NOT found"
	if EXIST "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"

	%CERTUTIL_EXE% -decode "%inputFile:/=\%" "%outputFile:/=\%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
	%dk_call% Base64::dk_decode "%dk_selectFile%"
%endfunction%
