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
	
	%dk_call% dk_import
	
rem	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
rem	if defined win_host		(set "nuget_Import=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
rem	if NOT defined nuget_Import	(%dk_call% dk_error "nuget_Import is invalid")

rem	%dk_call% dk_importVariables %nuget_Import% IMPORT_PATH "%DKIMPORTS_DIR%/nuget" ROOT "%DK3RDPARTY_DIR%"
rem	%dk_call% dk_set nuget_exe "%NUGET%/nuget.exe"
	
rem	if EXIST "%nuget_exe%" (%return%)
rem	%dk_call% dk_echo  
rem    %dk_call% dk_info "Installing nuget . . ."
rem    %dk_call% dk_download %nuget_Import%
rem	%dk_call% dk_copy "%dk_download%" "%nuget_exe%"
rem	%dk_call% dk_assertPath nuget_exe
rem	"%nuget_exe%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
%endfunction%
