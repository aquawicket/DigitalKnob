@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_C_FUNCTION___()
::#
::#
:___NEW_C_FUNCTION___
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE_H=%FUNCTION%.h"
	set "FUNCTION_FILE_C=%FUNCTION%.c"
	
	if EXIST "%FUNCTION_FILE_H%" (
		%dk_call% dk_notice "%FUNCTION_FILE_H% already exists"
		rem goto :edit_textfile
	)
	
	::###### <FUNCTION>.h ######
setlocal disableDelayedExpansion
	echo.#pragma once>  																																				"%FUNCTION_FILE_H%"
	echo.#ifndef %FUNCTION%_h>> 																																		"%FUNCTION_FILE_H%"
	echo.#define %FUNCTION%_h>>																																			"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
	echo.#include "DK.h">> 																																				"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
	echo.//################################################################################>> 																			"%FUNCTION_FILE_H%"
	echo.//# %FUNCTION%()>> 																																			"%FUNCTION_FILE_H%"
	echo.//#>> 																																							"%FUNCTION_FILE_H%"
	echo.int %FUNCTION%(){>> 																																			"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
	echo.>>																																								"%FUNCTION_FILE_H%"
	echo. 	return 0;>>																																					"%FUNCTION_FILE_H%"	
	echo.};>> 																																							"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
	echo.#endif //%FUNCTION%_h>> 																																		"%FUNCTION_FILE_H%"
	echo.>> 																																							"%FUNCTION_FILE_H%"
endlocal
	
	::###### <FUNCTION>.c ######
setlocal disableDelayedExpansion

	echo.///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" ^|^| $(which clang ^|^| which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" ^|^| exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%%s"' "$@")">		 "%FUNCTION_FILE_C%"
	echo.>> 																																							"%FUNCTION_FILE_C%"
	echo.#include "%FUNCTION%.h">> 																																		"%FUNCTION_FILE_C%"
	echo.>> 																																							"%FUNCTION_FILE_C%"
	echo.//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>																				"%FUNCTION_FILE_C%"
	echo.#ifndef DKMAIN>> 																																				"%FUNCTION_FILE_C%"
	echo.#define DKMAIN 1>>																																				"%FUNCTION_FILE_C%"
	echo.int main(int argc, char** argv){>>																																"%FUNCTION_FILE_C%"
	echo.>> 																																							"%FUNCTION_FILE_C%"
	echo.	return %FUNCTION%();>> 																																		"%FUNCTION_FILE_C%"	
	echo.}>> 																																							"%FUNCTION_FILE_C%"
	echo.#endif>> 																																						"%FUNCTION_FILE_C%"
	echo.>> 																																							"%FUNCTION_FILE_C%"
endlocal

	:edit_textfile
	%dk_call% dk_validate notepadpp_exe "%dk_call% dk_depend notepadpp_exe"
	"%notepadpp_exe%" "%FUNCTION_FILE_H%"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_C_FUNCTION___
%endfunction%
