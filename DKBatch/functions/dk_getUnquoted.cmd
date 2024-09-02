@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_getUnquoted(<variable> rtn_var)
::#
::#
:dk_getUnquoted
 setlocal
    call dk_debugFunc 2
    
    set _input=%1
    set _input=%_input:"=%
    if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
    if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
    for %%Z in ("%_input%") do set "_getUnquoted_=%%~Z"
    endlocal & set "%2=%_getUnquoted_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_getUnquoted "string" unquoted
    %dk_call% dk_echo "unquoted = %unquoted%"
%endfunction%
