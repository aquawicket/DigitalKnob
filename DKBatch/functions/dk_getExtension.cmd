@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getExtension(path rtn_var)
::#
::#
:dk_getExtension
    call dk_debugFunc 2
 setlocal
 
    set "_input_=%1"
    set "_input_=%_input_:"=%"
    if [%_input_:~-1%] == [\] set "_input_=%_input_:~0,-1%"
    if [%_input_:~-1%] == [/] set "_input_=%_input_:~0,-1%"
    for %%Z in ("%_input_%") do set "_extension_=%%~xZ"
    endlocal & set "%2=%_extension_%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "/test/test2/xfile.extension"
    %dk_call% dk_getExtension "%myPath%" extension
    %dk_call% dk_printVar extension
%endfunction%
