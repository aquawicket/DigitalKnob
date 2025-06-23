@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_stacktrace()
::#
:dk_stacktrace
%setlocal%
	%dk_call% dk_debugFunc 0
	
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (0, 1, 100) do (
		(set /a num=100-%%x)
		(set /a numb=99-%%x)
		if defined __STACK__!num! (
			call echo !num!: %%__STACK__!num!%%
		)
	)
	echo:
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::###### Create test files ######
	echo :dk_stacktrace_TEST_B>				dk_stacktrace_TEST_A.cmd
	echo %%dk_call%% dk_stacktrace_TEST_B>>	dk_stacktrace_TEST_A.cmd
	echo %%dk_call%% dk_stacktrace_TEST_C>>	dk_stacktrace_TEST_A.cmd
	echo %%endfunction%%>>					dk_stacktrace_TEST_A.cmd
	
	echo echo dk_stacktrace_TEST_B.cmd>		dk_stacktrace_TEST_B.cmd
	echo SYNTAX ERROR>>						dk_stacktrace_TEST_B.cmd
	echo %%endfunction%%>>					dk_stacktrace_TEST_B.cmd
	
	
	echo %%dk_call%% dk_stacktrace>			dk_stacktrace_TEST_C.cmd
	echo %%endfunction%%>>					dk_stacktrace_TEST_C.cmd
	
	%dk_call%  dk_stacktrace_TEST_A
	%dk_call% dk_stacktrace
%endfunction%

