@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_prependArgs(variable, string)
::#
::#
:dk_prependArgs
setlocal
    %dk_call% dk_debugFunc 2 99


	set ALL_BUT_FIRST=%*
	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)
	
    if defined %~1 endlocal & call set "%~1=%ALL_BUT_FIRST% %%%~1%% "
    if not defined %~1 endlocal & set "%~1=%ALL_BUT_FIRST%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar abc 123
    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar xyz 789
    %dk_call% dk_printVar myVar
%endfunction%
