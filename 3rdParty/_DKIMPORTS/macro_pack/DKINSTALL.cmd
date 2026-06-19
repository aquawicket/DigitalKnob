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
rem # DKINSTALL
rem #
:DKINSTALL
rem %setlocal%

	set "macro_pack_Import=https://github.com/sevagas/macro_pack/releases/download/v2.2.0/macro_pack.exe"
	if NOT defined macro_pack_Import (%dk_call% dk_error "macro_pack_Import is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables %macro_pack_Import% IMPORT_PATH %DKIMPORTS_DIR%/macro_pack
	%dk_call% dk_set macro_pack_exe "%macro_pack%/%macro_pack_IMPORT_FILE%"
	
	if EXIST "%macro_pack_exe%" (%return%)
	%dk_call% dk_info
	%dk_call% dk_info "Installing macro_pack . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_download %macro_pack_Import%
	%dk_call% dk_copy "%dk_download%" "%macro_pack%/%macro_pack_IMPORT_FILE%"
	if NOT EXIST "%macro_pack_exe%" (%dk_call% dk_error "macro_pack_exe:'%macro_pack_exe%' NOT FOUND")

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% DKINSTALL
%endfunction%
