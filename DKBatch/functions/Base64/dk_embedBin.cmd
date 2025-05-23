@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not defined dk_embedBin_DELETE_CMD_ON_EXTRACT 	(set "dk_embedBin_DELETE_CMD_ON_EXTRACT=0")
if not defined dk_embedBin_OVERWRITE_OUTPUT			(set "dk_embedBin_OVERWRITE_OUTPUT=1")
::##################################################################################
::# Base64::dk_embedBin(inputFile)
::# Base64::dk_embedBin(inputFile, outputFile)
::# Base64::dk_embedBin(inputFile, outputFile, OVERWRITE)
::#
::#	https://stackoverflow.com/a/19596027/688352
::#
:dk_embedBin
setlocal
	%dk_call% dk_debugFunc 1 3

	set "inputFile=%~1"
	set "inputFilename=%~nx1"
	if "%~2" equ "" (set "outputFile=%~nx1.cmd") else (set "outputFile=%~2")
	
	::if "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")
	:: Find OVERWRITE in any of the arguments
	set "args=%*"
	if not "X%args:OVERWRITE=%X" equ "X%args%X" (set "OVERWRITE=1")
	

	if not exist "%inputFile%" (%dk_call% dk_error "%inputFile% not found")
	if exist "%outputFile%" (
		if not "%OVERWRITE%" equ "1" (
			%dk_call% dk_error "dk_embedBin Cannot embed file. Destiantion already exists and OVERWRITE is not set"
		)
		del "%outputFile:/=\%"
	)

	if "%dk_embedBin_DELETE_CMD_ON_EXTRACT%" equ "1" (
		set DELETE_CMD_ON_EXTRACT=echo ;;;===,,,del "%outputFile:/=\%"
	)
	if not "%dk_embedBin_OVERWRITE_OUTPUT%" equ "1" (
		set OVERWRITE_OUTPUT=echo ;;;===,,,if exist "%inputFilename%" echo ERROR: outputfile already exists ^& pause ^& exit /b %%errorlevel%%
	)
	set "tempCmd=%inputFile%.tmp"
	(
	echo ;;;===,,,@echo off
	%OVERWRITE_OUTPUT%
	echo ;;;===,,,echo decoding . . .
	echo ;;;===,,,findstr /v "^;;;===,,," "%%~f0" ^> "%inputFilename%"
	echo ;;;===,,,start "" /b "%inputFilename%"
	%DELETE_CMD_ON_EXTRACT%
	echo ;;;===,,,exit /b %%errorlevel%%

	) >"%tempCmd%"

	copy /a "%tempCmd:/=\%" + /b "%inputFile:/=\%" /b "%outputFile:/=\%"
	del "%tempCmd:/=\%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_selectFile
	%dk_call% dk_embedBin "%dk_selectFile%"
%endfunction%
