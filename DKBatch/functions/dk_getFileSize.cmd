@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFileSize(path rtn_var)
::#
::#
:dk_getFileSize
setlocal
	%dk_call% dk_debugFunc 2

    set _input=%1
    set _input=%_input:"=%
    if [%_input:~-1%] == [\] set _input=%_input:~0,-1%
    if [%_input:~-1%] == [/] set _input=%_input:~0,-1%
    endlocal & for %%Z in ("%_input%") do set "%2=%%~zZ"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getFileSize "%myPath%" fileSize
    %dk_call% dk_printVar fileSize
%endfunction%
