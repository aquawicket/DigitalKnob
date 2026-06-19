rem shebang
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


rem ####################################################################
rem # DKUNINSTALL
rem #
:DKUNINSTALL
%setlocal%
	
	%dk_call% dk_fileVariables	"%~dp0/dkconfig.txt"
	%dk_call% dk_basename "%~dp0" PLUGIN
	%dk_call% dk_assertVar PLUGIN
	
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	%dk_call% dk_assertVar Host_Tuple
	echo Host_Tuple = %Host_Tuple%
	echo %PLUGIN%_%Host_Tuple%_Import = !%PLUGIN%_%Host_Tuple%_Import!
		
	set "%PLUGIN%_Import=!%PLUGIN%_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar %PLUGIN%_Import
	echo %PLUGIN%_Import = !%PLUGIN%_Import!

	%dk_call% dk_importVariables !%PLUGIN%_Import! IMPORT_PATH %DKIMPORTS_DIR%\%PLUGIN%
	%dk_call% dk_assertVar CURRENT_PLUGIN
	rem set %CURRENT_PLUGIN%

	echo %dk_call% dk_delete "!%CURRENT_PLUGIN%!"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% DKUNINSTALL
%endfunction%



