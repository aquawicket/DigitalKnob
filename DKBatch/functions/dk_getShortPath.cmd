@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getShortPath(path rtn_var)
::#
::#
:dk_getShortPath
setlocal
	%dk_call% dk_debugFunc 2

    set "_input=%1"
    set "_input=%_input:"=%"
    if [%_input:~-1%] == [\] set "_input=%_input:~0,-1%"
    if [%_input:~-1%] == [/] set "_input=%_input:~0,-1%"
    for %%Z in ("%_input%") do set "_shortPath_=%%~sZ"
    ::endlocal & %dk_call% dk_set %2 "%_shortPath_%"
    endlocal & set "%2=%_shortPath_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getShortPath "%ProgramFiles%" shortPath
    %dk_call% dk_echo "shortPath = %shortPath%"
%endfunction%
