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
rem # Base64::dk_decodeString(inputString, rtn_var:optional)
rem #
rem #	Decode base-64 input to output
rem #	https://github.com/base64code/examples
rem #
:dk_decodeString
%setlocal%

	set "inputString=%~1"
	set "thisPath=%~dp0"
	set "inputFile=%thisPath%%random%.b64"
	set "outputFile=%thisPath%%random%.b64"
	echo %inputString%> "%inputFile%"
	
	if NOT EXIST "%inputFile%" (
		%dk_call% dk_error "%inputFile% NOT found"
	)
	if EXIST "%outputFile%" (
		%dk_call% dk_error "%outputFile% already exists and cannot be overwritten"
	)

	%dk_call% certutil.exe -decode "%inputFile:/=\%" "%outputFile:/=\%" 1>nul 2>nul
	
	for /F "usebackq delims=" %%a in ("%outputFile:/=\%") do (
		setlocal disableDelayedExpansion
		set "dk_decodeString=%%a"
		
	)
	
	:return
	endlocal & endlocal & (
		set inputFile=%inputFile%
		set outputFile=%outputFile%
		set dk_decodeString=%dk_decodeString:!=^^!%
			if "%~2" neq "" (
				set %~2=!dk_decodeString!
			) else (
				echo !dk_decodeString!
			)
		)
	)
	
	del "%inputFile%"
	del "%outputFile%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% Base64::dk_decodeString "VHJpYWQyMzkzISE" output
	echo output = !output!
	echo "output" = "!output!"
	echo dk_decodeString = !dk_decodeString!
	echo "dk_decodeString" = "!dk_decodeString!"
	
	rem %dk_call% dk_echo dk_decodeString = %dk_decodeString%
	rem %dk_call% dk_echo "dk_decodeString = %dk_decodeString%"
	rem %dk_call% dk_echo dk_decodeString = !dk_decodeString!
	rem %dk_call% dk_echo "dk_decodeString = !dk_decodeString!"
	echo.
%endfunction%
