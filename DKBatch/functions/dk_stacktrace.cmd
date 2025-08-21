@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_stacktrace()
::#
:dk_stacktrace
%setlocal%
	%dk_call% dk_debugFunc 0
	
	echo(
	echo ############ CALLSTACK ############
	for /l %%x in (200, -1, 0) do (
		if defined __STACK__%%x (
			call echo %%x: !__STACK__%%x!
		)
	)
	echo(
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::##################### Create test files ##########################
	echo :dk_stacktrace_TEST_A>					dk_stacktrace_TEST_A.cmd
	echo %%dk_call%% dk_stacktrace_TEST_B>>		dk_stacktrace_TEST_A.cmd
	echo %%endfunction%%>>						dk_stacktrace_TEST_A.cmd
	
	echo :dk_stacktrace_TEST_B>					dk_stacktrace_TEST_B.cmd
	echo %%dk_call%% dk_stacktrace_TEST_C>>		dk_stacktrace_TEST_B.cmd
	echo %%endfunction%%>>						dk_stacktrace_TEST_B.cmd
	
	echo :dk_stacktrace_TEST_C>					dk_stacktrace_TEST_C.cmd
	echo %%dk_call%% dk_stacktrace_TEST_ERROR>>	dk_stacktrace_TEST_C.cmd
	echo %%dk_call%% dk_stacktrace_TEST_D>>		dk_stacktrace_TEST_C.cmd
	echo %%endfunction%%>>						dk_stacktrace_TEST_C.cmd
	
	echo :dk_stacktrace_TEST_D>					dk_stacktrace_TEST_D.cmd
	echo %%endfunction%%>>						dk_stacktrace_TEST_D.cmd
	
	echo :dk_stacktrace_TEST_ERROR>				dk_stacktrace_TEST_ERROR.cmd
	echo SYNTAX ERROR>>							dk_stacktrace_TEST_ERROR.cmd
	echo %%endfunction%%>>						dk_stacktrace_TEST_ERROR.cmd
	::######################################################################
	
	%dk_call% dk_stacktrace_TEST_A

	::%dk_call% dk_stacktrace
%endfunction%

