@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_appendArgs(variable, string)
::#
::#
:dk_appendArgs
    call dk_debugFunc 2 99
 setlocal
 
    for /f "tokens=1,* delims= " %%a in ("%*") do set "ALL_BUT_FIRST=%%b"

    if defined %~1 endlocal & call set "%~1=%%%~1%% %ALL_BUT_FIRST%"
    if not defined %~1 endlocal & set "%~1=%ALL_BUT_FIRST%
	
%DEBUG%
	%dk_call% dk_printVar %1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_appendArgs myVar 123 abc
    %dk_call% dk_debug "myVar = %myVar%"

    %dk_call% dk_appendArgs myVar 456 zyx
    %dk_call% dk_debug "myVar = %myVar%"
%endfunction%
