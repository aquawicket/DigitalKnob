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


rem ############################################################################
rem # Services/dk_partialMatch(string)
rem #
rem #
:dk_partialMatch
%setlocal%

	set "string=%1"

	echo #### Windows Services containing %string% ####
	sc queryex type= service state= all | find /i %string%

	rem output of command to a variable
	rem for /f "delims=" %%i in ('command') do set output=%%i

	rem last 5 chaacters of the string
	rem set "substring=%i~-5%"
	rem echo "%substring%"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% Services/dk_partialMatch "Windows Push Notifications User Service"
%endfunction%