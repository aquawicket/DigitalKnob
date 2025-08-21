@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# Base64::dk_encode(inputFile)
::# Base64::dk_encode(inputFile, outputFile)
::# Base64::dk_encode(inputFile, outputFile, OVERWRITE)
::#
::#	Encode input to base-64 output
::#	https://github.com/base64code/examples
::#
:dk_encode
%setlocal%
	%dk_call% dk_debugFunc 1 3

	set "inputFile=%~1"
	if "%~2" equ "" (set "outputFile=%inputFile%.b64") else (set "outputFile=%~2")
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	if NOT EXIST "%inputFile%" (%dk_call% dk_error "%inputFile% NOT found")
	if EXIST "%outputFile%" (%dk_call% dk_error "%outputFile% already exists and cannot be overwritten")

	%CERTUTIL_EXE% -encode -f "%inputFile:/=\%" "%outputFile:/=\%.tmp" 1>nul

	type "%outputFile:/=\%.tmp"|find /v "CERTIFICATE-----">"%outputFile:/=\%"
	del "%outputFile:/=\%.tmp"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_selectFile
	%dk_call% Base64::dk_encode "%dk_selectFile%"
%endfunction%
