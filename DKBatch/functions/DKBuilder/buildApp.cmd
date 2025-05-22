@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# buildApp()
::#
::#
:buildApp
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_title "Building %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Building %Target_App% - %Target_Tuple% - %Target_Type% - %Target_Level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo

	%dk_call% dk_assertVar Target_Type
	if "%Target_Type%" equ "All"		%dk_call% DKBuilder/buildAll
	if "%Target_Type%" equ "Release"	%dk_call% DKBuilder/buildRelease
	if "%Target_Type%" equ "Debug"		%dk_call% DKBuilder/buildDebug

	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Done Building %Target_App% - %Target_Tuple% - %Target_Type% - %Target_Level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% buildApp
%endfunction%
