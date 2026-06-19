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
rem # dk_adsExecute(adsPath)
rem #
rem #
:dk_adsExecute
%setlocal%
 
	set "adsPath=%~1"
	
	goto :method2
	
	rem ### Method 1 - extract and execute
	:method1
	%dk_call% dk_basename "%adsPath%"
	set "dk_basename=%dk_basename:*:=%"
	%dk_call% ADS\dk_adsExtractFile "%adsPath%" && %dk_basename%
	%return%

	rem ### Method 2 - wmic process
	:method2
	wmic process call create '"%adsPath:/=\%"'
	%return%
	
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
	%dk_call% ADS\dk_adsExecute "%dk_selectFile%:DKBuilder.cmd"
%endfunction%

