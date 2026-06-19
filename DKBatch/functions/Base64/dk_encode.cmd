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
rem # Base64::dk_encode(inputFile)
rem # Base64::dk_encode(inputFile, outputFile)
rem # Base64::dk_encode(inputFile, outputFile, OVERWRITE)
rem #
rem #	Encode input to base-64 output
rem #	https://github.com/base64code/examples
rem #
:dk_encode
%setlocal%

	set "inputFile=%~1"
	if "%~2" equ "" (set "outputFile=%inputFile%.b64") else (set "outputFile=%~2")
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	if NOT EXIST "%inputFile%" (%dk_call% dk_error "%inputFile% NOT found")
	if EXIST "%outputFile%" (%dk_call% dk_error "%outputFile% already exists and cannot be overwritten")

	%CERTUTIL_EXE% -encode -f "%inputFile:/=\%" "%outputFile:/=\%.tmp" 1>nul

	type "%outputFile:/=\%.tmp"|find /v "CERTIFICATE-----">"%outputFile:/=\%"
	del "%outputFile:/=\%.tmp"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
	%dk_call% Base64::dk_encode "%dk_selectFile%"
%endfunction%
