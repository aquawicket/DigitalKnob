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
rem # Base64::dk_embedFile(inputFile)
rem # Base64::dk_embedFile(inputFile, outputFile)
rem #
rem #	Encode input to base-64 output
rem #	https://github.com/base64code/examples
rem #
:dk_embedFile
%setlocal%

	set "inputFile=%~1"
	set "outputFile=%~nx1.cmd"
	if "%~2" neq "" (set "outputFile=%~2")

	if NOT EXIST "%inputFile%" (%dk_call% dk_error "%inputFile% NOT found")
	if EXIST "%outputFile%" (del %outputFile%)
	rem if EXIST "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	
	(
	echo @echo off
	echo setlocal enabledelayedexpansion
	echo.
	echo set FN=%%TEMP%%\%~nx1
	echo call :extract-embedded-bin "%%FN%%"
	echo start %%FN%%
	echo goto :eof
	echo.
	echo :extract-embedded-bin ::1=OutFileName
	echo setlocal
	echo.
	echo set MBEGIN=-1
	echo for /f "useback tokens=1 delims=: " %%%%a in (`%findstr.exe% /B /N /C:"-----BEGIN CERTIFICATE-----" "%%~f0"`^) DO (
	echo	set /a MBEGIN=%%%%a-1
	echo ^)
	echo.
	echo if "%%MBEGIN%%" equ "-1" (
	echo	endlocal
	echo	exit /b -1
	echo ^)
	echo.
	echo ::Delete previous output files
	echo if EXIST "%%~1.tmp" del "%%~1.tmp"
	echo if EXIST "%%~1" del "%%~1"
	echo.
	echo for /f "useback skip=%%MBEGIN%% tokens=* delims=" %%%%a in ("%%~f0"^) DO (
	echo 	echo %%%%a ^>^>"%%~1.tmp"
	echo ^)
	echo %certutil.exe% -decode "%%~1.tmp" "%%~1" ^>nul 2^>^&1
	echo del "%%~1.tmp"
	echo.
	echo endlocal
	echo exit /b 0
	echo.
	) >"%outputFile%"

	%certutil.exe% -encode -f "%inputFile%" "encoded.tmp"
	type "encoded.tmp">>"%outputFile%"
	del "encoded.tmp"
	
	:return
	endlocal & (
		set "findstr.exe=%findstr.exe%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem %dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	rem set "input=%DKBRANCH_DIR%/DKBuilder.cmd"
	rem set "output=%DKBRANCH_DIR%/DKBuilder.cmd.b64"

	%dk_call% dk_selectFile
	%dk_call% dk_embedFile "%dk_selectFile%"

	rem %dk_call% Base64::dk_encode "%input%" "test.b64"
%endfunction%
