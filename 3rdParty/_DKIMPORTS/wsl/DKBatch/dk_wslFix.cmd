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



rem ##################################################################################
::# dk_wslFix()
::#
::#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
::#
:dk_wslFix
%setlocal%

	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR_ %dk_call% dk_DKBRANCH_DIR

	if NOT defined DKHTTP_DKBASH_DIR            set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR%\DK.sh" %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh"
	
	set DKBASH_COMMAND="%wsl.exe% sh -c '. %DKBASH_FUNCTIONS_DIR%/dk_wslFix.sh ^&^& dk_wslFix'"
	%DKBASH_COMMAND%

%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_wslFix
%endfunction%
