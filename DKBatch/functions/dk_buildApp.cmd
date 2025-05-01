@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_buildApp()
::#
::#
:dk_buildApp
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_title "Building %target_app% - %target_triple% - %target_type%"
	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Building %target_app% - %target_triple% - %target_type% - %target_level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo

	%dk_call% dk_assertVar target_type
	if "%target_type%" equ "All"		%dk_call% dk_buildAll
	if "%target_type%" equ "Release"	%dk_call% dk_buildRelease
	if "%target_type%" equ "Debug"		%dk_call% dk_buildDebug

	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Done Building %target_app% - %target_triple% - %target_type% - %target_level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_buildApp
%endfunction%
