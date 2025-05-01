@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# ___NEW_FUNCTION()
::#
::#
:___NEW_FUNCTION
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	%dk_call% dk_printVar dk_inputBox
	
	if exist %dk_inputBox%.cmd (
		%dk_call% dk_notice "function %dk_inputBox% already exists"
		goto :edit_textfile
	)
	
	echo @echo off^&::########################################## DigitalKnob DKBatch ########################################################################>			"%dk_inputBox%.cmd"
	echo if not exist "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" for /F "tokens=*" %%%%G IN ('where /r "%%USERPROFILE%%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%%%~dpG")>>	"%dk_inputBox%.cmd"
	echo if not defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" "%%~0" %%*)>>																					"%dk_inputBox%.cmd"
	echo ::#################################################################################################################################################>>			"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo ::############################################################################>> 	"%dk_inputBox%.cmd"
	echo ::# %dk_inputBox%()>> 																"%dk_inputBox%.cmd"
	echo ::#>> 																				"%dk_inputBox%.cmd"
	echo ::#>>	 																			"%dk_inputBox%.cmd"
	echo :%dk_inputBox%>> 																	"%dk_inputBox%.cmd"
	echo %%setlocal%%>> 																	"%dk_inputBox%.cmd"
	echo 	%%dk_call%% dk_debugFunc 0>>													"%dk_inputBox%.cmd"
	echo:>>																					"%dk_inputBox%.cmd"
	echo 	::insert function code here::>>													"%dk_inputBox%.cmd"
	echo:>>																					"%dk_inputBox%.cmd"
	echo %%endfunction%%>>	 																"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	echo ::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>	"%dk_inputBox%.cmd"
	echo :DKTEST>>	 																		"%dk_inputBox%.cmd"
	echo %%setlocal%%>>						 												"%dk_inputBox%.cmd"
	echo 	%%dk_call%% dk_debugFunc 0>> 													"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd" 
	echo 	%%dk_call%% %dk_inputBox%>>														"%dk_inputBox%.cmd"
	echo %%endfunction%%>>	 																"%dk_inputBox%.cmd"
	echo:>> 																				"%dk_inputBox%.cmd"
	
	:edit_textfile
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
	"%NOTEPADPP_EXE%" "%dk_inputBox%.cmd"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_FUNCTION
%endfunction%
