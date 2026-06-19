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
rem # DKINSTALL()
rem #
:DKINSTALL
rem %setlocal%
	
	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	set "nodejs_Import=!NodeJS_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar nodejs_Import
	
	%dk_call% dk_importVariables %nodejs_Import%
	%dk_call% dk_assertVar nodejs
	
    %dk_call% dk_set nodejs_exe "%nodejs%/node.exe"
    if EXIST "%nodejs_exe%" (%return%)
	
    %dk_call% dk_info
    %dk_call% dk_info "Installing NodeJS . . ."
    %dk_call% dk_download "%nodejs_Import%"
	%dk_call% dk_smartExtract "%dk_download%" "%nodejs%"
	%dk_call% dk_assertPath nodejs_exe
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% DKINSTALL
%endfunction%
