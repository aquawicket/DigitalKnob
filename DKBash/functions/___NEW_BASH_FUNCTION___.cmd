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
::# ___NEW_BASH_FUNCTION___()
::#
::#
:___NEW_BASH_FUNCTION___
%setlocal%

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.sh"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	>"${FUNCTION_FILE}" (
		echo.#!/usr/bin/env bash
		echo.###### DK.sh #####################################################################
		echo. [ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
		echo.##################################################################################
		echo.
		echo.
		echo.##################################################################################
		echo.# ${FUNCTION}()
		echo.#
		echo.#
		echo.${FUNCTION}() {
		echo.	dk_debugFunc 0
		echo.
		echo.}
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
		echo.DKTEST() {
		echo.	dk_debugFunc 0
		echo.
		echo.	${FUNCTION}
		echo.	dk_call dk_debug("FUNCTION = ${FUNCTION}")
		echo.}
	)
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	"%notepadpp_exe%" "${FUNCTION_FILE}"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% ___NEW_BASH_FUNCTION___
%endfunction%
