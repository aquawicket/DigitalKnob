@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_BATCH_FUNCTION___()
::#
::#
:___NEW_BATCH_FUNCTION___
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.cmd"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	echo.@echo off^&::###### DK.cmd #########################################################################################################################>			"%FUNCTION_FILE%"
	echo.if NOT EXIST "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>	"%FUNCTION_FILE%"
	echo.if NOT defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%FUNCTION_FILE%"
	echo.::#################################################################################################################################################>>			"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.::############################################################################>> 																				"%FUNCTION_FILE%"
	echo.::# %dk_inputBox%()>> 																																			"%FUNCTION_FILE%"
	echo.::#>> 																																							"%FUNCTION_FILE%"
	echo.::#>>	 																																						"%FUNCTION_FILE%"
	echo.:%dk_inputBox%>> 																																				"%FUNCTION_FILE%"
	echo.%%setlocal%%>> 																																				"%FUNCTION_FILE%"
	echo. 	%%dk_call%% dk_debugFunc 0 >>																																"%FUNCTION_FILE%"
	echo.>>																																								"%FUNCTION_FILE%"
	echo.	::insert function code here::>>																																"%FUNCTION_FILE%"
	echo.>>																																								"%FUNCTION_FILE%"
	echo.%%endfunction%%>>	 																																			"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>																				"%FUNCTION_FILE%"
	echo.:DKTEST>>	 																																					"%FUNCTION_FILE%"
	echo.%%setlocal%%>>						 																															"%FUNCTION_FILE%"
	echo.	%%dk_call%% dk_debugFunc 0 >> 																																"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	echo.	%%dk_call%% %dk_inputBox%>>																																	"%FUNCTION_FILE%"
	echo.%%endfunction%%>>	 																																			"%FUNCTION_FILE%"
	echo.>> 																																							"%FUNCTION_FILE%"
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe "%dk_call% dk_depend notepadpp_exe"
	"%notepadpp_exe%" "%FUNCTION_FILE%"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_BATCH_FUNCTION___
%endfunction%
