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
rem # dk_openLineNumber(filepath, lineno)
rem #
rem #
:dk_openLineNumber
%setlocal%

	set "filepath=%~1"
	set "lineno=%~2"

	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	start "" "%notepadpp_exe%" "%filepath%" -n%lineno%
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem %dk_call% dk_openLineNumber "%USERPROFILE:\=/%/Digital Knob/Development/README.md"
	%dk_call% dk_openLineNumber "%USERPROFILE:\=/%/Digital Knob/Development/README.md" 23
%endfunction%

