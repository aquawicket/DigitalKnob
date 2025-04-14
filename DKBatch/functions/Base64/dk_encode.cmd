@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::##################################################################################
::# Base64::dk_encode(inputFile)
::# Base64::dk_encode(inputFile, outputFile)
::# Base64::dk_encode(inputFile, outputFile, OVERWRITE)
::#
::#	Encode input to base-64 output
::#	https://github.com/base64code/examples
::#
:dk_encode
setlocal
	%dk_call% dk_debugFunc 1 3

	set "inputFile=%~1"
	if "%~2" equ "" (set "outputFile=%inputFile%.b64") else (set "outputFile=%~2")
	if "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	if not exist "%inputFile%" (%dk_call% dk_error "%inputFile% not found")
	if exist "%outputFile%" (%dk_call% dk_error "%outputFile% already exists and cannot be overwritten")

	certutil -encode -f "%inputFile:/=\%" "%outputFile:/=\%.tmp" 1>nul

	type "%outputFile:/=\%.tmp"|find /v "CERTIFICATE-----">"%outputFile:/=\%"
	del "%outputFile:/=\%.tmp"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_selectFile
	%dk_call% Base64::dk_encode "%dk_selectFile%"
%endfunction%
