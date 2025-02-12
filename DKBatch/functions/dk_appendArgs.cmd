@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_appendArgs(variable, string)
::#
::#
:dk_appendArgs
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 99

	set ALL_BUT_FIRST=%*
	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)
	
    if defined %~1 endlocal & (
		call set "%~1=%%%~1%%%ALL_BUT_FIRST%"
	)
    if not defined %~1 endlocal & (
		set "%~1=%ALL_BUT_FIRST%
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_appendArgs myVar 123 abc
    %dk_call% dk_echo "myVar = %myVar%"

    %dk_call% dk_appendArgs myVar 456 def
    %dk_call% dk_echo "myVar = %myVar%"
	
	%dk_call% dk_appendArgs myVar 789 ghi
    %dk_call% dk_echo "myVar = %myVar%"
%endfunction%
