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
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	
	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	set "wsl_alpine_Import=!Wsl_Alpine_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar WSL_ALPINE_IMPORT

	%dk_call% dk_validate wsl %dk_call% dk_depend wsl
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables %WSL_ALPINE_IMPORT% ROOT %DKTOOLS_DIR%
	
	if EXIST "%LAUNCHER_IMPORT_FILE%" (%return%)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing Alpine Linux . . ."
	%dk_call% dk_download "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_mkdir "%WSL_ALPINE%"
	%dk_call% dk_basename "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_copy "%dk_download%" "%WSL_ALPINE%/%dk_basename%" OVERWRITE
	%dk_call% dk_firewallAllow "%WSL_ALPINE%/%dk_basename%"

	%dk_call% dk_assertPath "%WSL_ALPINE%/%dk_basename%"
	
	::%dk_call% dk_debug "%WSL_ALPINE:/=\%\%dk_basename% config --default-user root"
	%WSL_ALPINE:/=\%\%dk_basename% config --default-user root
	::%dk_call% dk_echo "%WSL_ALPINE:/=\%\%dk_basename%"
	%WSL_ALPINE:/=\%\%dk_basename%
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
%endfunction%
