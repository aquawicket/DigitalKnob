@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_dirname(path rtn_var)
::#
::#   https://en.wikipedia.org/wiki/Dirname
::#
:dk_dirname
    call dk_debugFunc 2
 setlocal
 
    set "_input_=%1"
    set "_input_=%_input_:"=%"
    if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
    if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
    for %%Z in ("%_input_%") do set "_dirname_=%%~dpZ"
    endlocal & set "%2=%_dirname_:~0,-1%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "C:\Windows\System32"
    %dk_call% dk_dirname "%myPath%" result
    %dk_call% dk_printVar result
%endfunction%
