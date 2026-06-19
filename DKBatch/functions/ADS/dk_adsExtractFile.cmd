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
rem # dk_adsExtractFile(adsPath)
rem #
rem #
:dk_adsExtractFile
%setlocal%
 
	set "adsPath=%~1"
	set "adsPath=%adsPath:/=\%"
	
	%dk_call% ADS\dk_adsExists "%adsPath%" || (
		%dk_call% dk_error "adsStream:'%adsPath%' NOT FOUND"
		%return%
	)
	
	%dk_call% dk_basename "%adsPath%"
	set "dk_basename=%dk_basename:*:=%"

	set "expand_exe=%SystemRoot%\System32\expand.exe"
	%expand_exe% "%adsPath%" "%dk_basename%"
	rem powershell -C $a = Get-Content %~1 -Encoding Byte -ReadCount 0;Set-Content %~2 -Encoding Byte -Value $a
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_ %dk_call% dk_DKBRANCH_DIR
	%dk_call% ADS\dk_adsExtractFile "%DKBATCH_FUNCTIONS_DIR_%ADS/DKADS.txt:DKBuilder.cmd"
%endfunction%

