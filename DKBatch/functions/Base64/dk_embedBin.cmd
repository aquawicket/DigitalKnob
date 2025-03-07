@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

set "dk_embedBin_DELETE_CMD_ON_EXTRACT=0"
set "dk_embedBin_OVERWRITE_OUTPUT=1"
::##################################################################################
::# Base64::dk_embedBin(inputFile)
::# Base64::dk_embedBin(inputFile, outputFile)
::# Base64::dk_embedBin(inputFile, outputFile, OVERWRITE)
::#
::#    https://stackoverflow.com/a/19596027/688352
::#
:dk_embedBin
setlocal
	%dk_call% dk_debugFunc 1 3

	set "inputFile=%~1"
	set "inputFilename=%~nx1"
	if "%~2"=="" (set "outputFile=%~nx1.cmd") else (set "outputFile=%~2")
	if "%~3"=="OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	if not exist "%inputFile%" (%dk_call% dk_error "%inputFile% not found")
	if exist "%outputFile%" (
		if not "%OVERWRITE%"=="1" (
			%dk_call% dk_error "dk_embedBin Cannot embed file. Destiantion already exists and OVERWRITE is not set"
		)
		del "%outputFile:/=\%"
	)

	if "%dk_embedBin_DELETE_CMD_ON_EXTRACT%"=="1" (
		set DELETE_CMD_ON_EXTRACT=echo ;;;===,,,del "%outputFile:/=\%"
	)
	if not "%dk_embedBin_OVERWRITE_OUTPUT%"=="1" (
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

    ::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::set "input=%DKBRANCH_DIR%/DKBuilder.cmd"
    ::set "output=%DKBRANCH_DIR%/DKBuilder.cmd.b64"
	
    %dk_call% dk_selectFile
    %dk_call% dk_embedBin "%dk_selectFile%"
	
    ::%dk_call% Base64::dk_encode "%input%" "test.b64"
%endfunction%
