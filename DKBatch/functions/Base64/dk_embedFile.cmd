@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# Base64::dk_embedFile(inputFile)
::# Base64::dk_embedFile(inputFile, outputFile)
::#
::#	Encode input to base-64 output
::#	https://github.com/base64code/examples
::#
:dk_embedFile
setlocal
	%dk_call% dk_debugFunc 0 99

	set "inputFile=%~1"
	set "outputFile=%~nx1.cmd"
	if "%~2" neq "" (set "outputFile=%~2")

	if not exist "%inputFile%" (%dk_call% dk_error "%inputFile% not found")
	if exist "%outputFile%" (del %outputFile%)
	:: if exist "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"

	(
	echo @echo off
	echo setlocal enabledelayedexpansion
	echo:
	echo set FN=%%TEMP%%\%~nx1
	echo call :extract-embedded-bin "%%FN%%"
	echo start %%FN%%
	echo goto :eof
	echo:
	echo :extract-embedded-bin ::1=OutFileName
	echo setlocal
	echo:
	echo set MBEGIN=-1
	echo for /f "useback tokens=1 delims=: " %%%%a in (`findstr /B /N /C:"-----BEGIN CERTIFICATE-----" "%%~f0"`^) DO (
	echo	set /a MBEGIN=%%%%a-1
	echo ^)
	echo:
	echo if "%%MBEGIN%%" equ "-1" (
	echo	endlocal
	echo	exit /b -1
	echo ^)
	echo:
	echo ::Delete previous output files
	echo if exist "%%~1.tmp" del "%%~1.tmp"
	echo if exist "%%~1" del "%%~1"
	echo:
	echo for /f "useback skip=%%MBEGIN%% tokens=* delims=" %%%%a in ("%%~f0"^) DO (
	echo 	echo %%%%a ^>^>"%%~1.tmp"
	echo ^)
	echo certutil -decode "%%~1.tmp" "%%~1" ^>nul 2^>^&1
	echo del "%%~1.tmp"
	echo:
	echo endlocal
	echo exit /b 0
	echo:
	) >"%outputFile%"

	certutil -encode -f "%inputFile%" "encoded.tmp"
	type "encoded.tmp">>"%outputFile%"
	del "encoded.tmp"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	::set "input=%DKBRANCH_DIR%/DKBuilder.cmd"
	::set "output=%DKBRANCH_DIR%/DKBuilder.cmd.b64"

	%dk_call% dk_selectFile
	%dk_call% dk_embedFile "%dk_selectFile%"

	::%dk_call% Base64::dk_encode "%input%" "test.b64"
%endfunction%
