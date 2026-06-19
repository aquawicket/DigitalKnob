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
	if NOT defined tcc-rt_Import	(%dk_call% dk_error "tcc-rt_Import is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables %tcc-rt_Import% INSTALL_ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_set tcc-rt_exe "%tcc-rt%/tcc.exe"
	if NOT EXIST "%tcc-rt_exe%" (%return%)
	
	rem  UNINSTALL
	%dk_call% dk_echo  
    %dk_call% dk_info "UnInstalling tcc-rt . . ."
	%dk_call% msiexec.exe /uninstall {B11E65DB-66DF-4987-9D13-014EFC915DF2} /quiet
	
	if EXIST "%SystemDrive%/Users/Public/Desktop/TCC-RT 32.lnk" (
		%dk_call% dk_delete "%SystemDrive%/Users/Public/Desktop/TCC-RT 32.lnk"
	)
%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%
