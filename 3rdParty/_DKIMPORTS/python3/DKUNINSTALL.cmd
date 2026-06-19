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
	
	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	
	set "python3_Import=!Python3_%Host_Tuple%_Import!"
rem 	if NOT defined python3_Import	(set "python3_Import=python3")
	
	rem %dk_call% dk_isUrl %python3_Import% && (
		%dk_call% dk_importVariables "%python3_Import%" IMPORT_PATH %~dp0
	rem )

	rem  UNINSTALL
	%dk_call% dk_delete "%python3%"
	
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%