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


rem ############################################################################
::# ___NEW_POWERSHELL_FUNCTION___()
::#
::#
:___NEW_POWERSHELL_FUNCTION___
%setlocal%

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.ps1"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	>"%FUNCTION_FILE%" (
		echo.if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }	
		echo.if(^!$%FUNCTION%_ps1){ $%FUNCTION%_ps1 = 1; } else{ return; } #include guard
		echo.
		echo.
		echo.################################################################################
		echo.# %FUNCTION%()
		echo.#
		echo.#    Function description
		echo.#
		echo.#    @arg1	- arg1 description
		echo.#
		echo.function Global:%FUNCTION%() {
		echo.	dk_debugFunc 0 99;
		echo.
		echo.
		echo.}
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
		echo.function Global:DKTEST() {
		echo.	dk_debugFunc 0;
		echo.
		echo.	dk_call %FUNCTION%;
		echo.}
	)
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	"%notepadpp_exe%" "%FUNCTION_FILE%"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% ___NEW_POWERSHELL_FUNCTION___
%endfunction%
