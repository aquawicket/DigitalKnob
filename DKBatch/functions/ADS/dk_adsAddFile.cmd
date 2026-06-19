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
rem # ADS/dk_adsAddFile(filepath, adsPath)
rem #
rem #
:dk_adsAddFile
%setlocal%

	set "filepath=%~1"
	%dk_call% dk_assertPath %filepath%
	set "filepath=%filepath:/=\%"
	
	set "asdPath=%~2"
	set "asdPath=%asdPath:/=\%"
	
	if not exist "%asdPath%" (
		echo. > "%asdPath%"
	)
	%dk_call% dk_basename %filepath%
	type "%filepath%" > "%asdPath%:%dk_basename%"
%endfunction%















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_ %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_selectFile
	%dk_call% ADS\dk_adsAddFile "%dk_selectFile%" "%DKBATCH_FUNCTIONS_DIR_%ADS/DKADS.txt"
%endfunction%

