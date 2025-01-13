@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_stacktrace()
::#
:dk_stacktrace
setlocal
	%dk_call% dk_debugFunc 0
	
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		(set /a numb=99-%%x)
		if defined __FILE__!num! (
			call echo !num!: %%__FILE__!numb!%% %%__FUNC__!num!%% %%__ARGV__!num!%%
		)
	)
	echo:
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_stacktrace
%endfunction%