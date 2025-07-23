@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_BASH_FUNCTION___()
::#
::#
:___NEW_BASH_FUNCTION___
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.sh"
	
	if exist %FUNCTION_FILE% (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	echo(#!/usr/bin/env bash>																	"${FUNCTION_FILE}"
	echo(###### DK.sh #####################################################################>>	"${FUNCTION_FILE}"
	echo( [ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*>>				"${FUNCTION_FILE}"
	echo(##################################################################################>>	"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(##################################################################################>>	"${FUNCTION_FILE}"
	echo(# ${FUNCTION}()>>																		"${FUNCTION_FILE}"
	echo(#>>																					"${FUNCTION_FILE}"
	echo(#>>																					"${FUNCTION_FILE}"
	echo(${FUNCTION}() {>>																		"${FUNCTION_FILE}"
	echo(	dk_debugFunc 0>>																	"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(}>>																					"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>			"${FUNCTION_FILE}"
	echo(DKTEST() {>>																			"${FUNCTION_FILE}"
	echo(	dk_debugFunc 0>>																	"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"
	echo(>>	${FUNCTION}																			"${FUNCTION_FILE}"	
	echo(>>	dk_call dk_debug("FUNCTION = ${FUNCTION}")											"${FUNCTION_FILE}"
	echo(>>																						"${FUNCTION_FILE}"	
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
	"%NOTEPADPP_EXE%" "${FUNCTION_FILE}"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_BASH_FUNCTION___
%endfunction%
