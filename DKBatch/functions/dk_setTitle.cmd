@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::################################################################################
::# dk_setTitle(string)
::#
::#
:dk_setTitle
    call dk_debugFunc 0 99
 setlocal
 
    title %*
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setTitle "DKTEST()"
%endfunction%
