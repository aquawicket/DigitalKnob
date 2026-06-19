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
rem # Base64::dk_embedBin(inputFile)
rem # Base64::dk_embedBin(inputFile, outputFile)
rem # Base64::dk_embedBin(inputFile, outputFile, OVERWRITE)
rem #
rem #	https://stackoverflow.com/a/19596027/688352
rem #
:dk_embedBin
if NOT defined dk_embedBin_DELETE_CMD_ON_EXTRACT 	(set "dk_embedBin_DELETE_CMD_ON_EXTRACT=0")
if NOT defined dk_embedBin_OVERWRITE_OUTPUT		(set "dk_embedBin_OVERWRITE_OUTPUT=1")
%setlocal%

	set "inputFile=%~1"
	set "inputFilename=%~nx1"
	if "%~2" equ "" (set "outputFile=%~nx1.cmd") else (set "outputFile=%~2")
	
	rem if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")
	rem Find OVERWRITE in any of the arguments
	rem set args=%*
	rem if "X%args:OVERWRITE=%X" neq "X%args%X" (set "OVERWRITE=1")
	

	if NOT EXIST "%inputFile%" (%dk_call% dk_error "%inputFile% NOT found")
	if EXIST "%outputFile%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_embedBin Cannot embed file. Destiantion already exists and OVERWRITE is NOT set"
		)
		del "%outputFile:/=\%"
	)

	if "%dk_embedBin_DELETE_CMD_ON_EXTRACT%" equ "1" (
		set DELETE_CMD_ON_EXTRACT=echo ;;;===,,,del "%outputFile:/=\%"
	)
	if "%dk_embedBin_OVERWRITE_OUTPUT%" neq "1" (
		set OVERWRITE_OUTPUT=echo ;;;===,,,if EXIST "%inputFilename%" echo ERROR: outputfile already exists ^& pause ^& exit /b %%errorlevel%%
	)
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	set "tempCmd=%inputFile%.tmp"
	(
		echo ;;;===,,,@echo off
		%OVERWRITE_OUTPUT%
		echo ;;;===,,,echo decoding . . .
		echo ;;;===,,,%findstr.exe% /v "^;;;===,,," "%%~f0" ^> "%inputFilename%"
		echo ;;;===,,,start "" /b "%inputFilename%"
		%DELETE_CMD_ON_EXTRACT%
		echo ;;;===,,,exit /b %%errorlevel%%
	) >"%tempCmd%"

	copy /a "%tempCmd:/=\%" + /b "%inputFile:/=\%" /b "%outputFile:/=\%"
	del "%tempCmd:/=\%"
	
	:return
	endlocal & (
		set "findstr.exe=%findstr.exe%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
	%dk_call% Base64/dk_embedBin "%dk_selectFile%"
%endfunction%
