@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_stacktrace()
::#
:dk_stacktrace
setlocal enableDelayedExpansion
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
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_stacktrace
%endfunction%