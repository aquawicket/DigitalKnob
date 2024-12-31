@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getNativePath(path rtn_var)
::#
::#
:dk_getNativePath
    %dk_call% dk_debugFunc 2
 setlocal
 
    set _input=%1
    set _input=%_input:"=%
    if [%_input:~-1%] == [\] set _input=%_input:~0,-1%
    if [%_input:~-1%] == [/] set _input=%_input:~0,-1%
    endlocal & for %%Z in ("%_input%") do set "%2=%%~fZ"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "C:/Windows/System32"
    %dk_call% dk_getNativePath "%myPath%" nativePath
    %dk_call% dk_printVar nativePath
%endfunction%
